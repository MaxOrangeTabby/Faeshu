extends CharacterBody2D
class_name Player

@onready var animation_tree : AnimationTree =  $AnimationTree
@onready var character_state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var sword_hitbox : Area2D = $SwordHitbox

@export var weapon_model : Node2D

@export_group('move')
@export var speed: int = 120
@export var acceleration: int = 700
@export var friction: int = 900

@export_group('jump')
@export var jump_strengh: int = 350
@export var gravity: int = 600
@export var term_vel: int = 500


var jump: bool = false
var wall_jump: bool = false
var faster_fall: bool = false


@export var direction: Vector2 = Vector2.ZERO
@export var prev_direction: Vector2 = Vector2.ZERO
var can_move: bool = true
var on_wall: bool = false
var dash: bool = false
@export_range(0,2, .1) var cooldown = .5


var can_attack: bool = true
var attacking: bool = false

const GRAVITY_CONST: int = 600

@export_group('chain')
const CHAIN_STRENGH = 55
var chain_velocity := Vector2(0,0)




func _ready():
	
	animation_tree.active = true
	weapon_model = $Weapon


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed and GlobalS.grapple_enabled:
			$Chain.shoot(position.direction_to(get_global_mouse_position()), self.global_position)
		else:
			$Chain.release()

func _physics_process(delta: float) -> void:
	#print(position.direction_to(get_global_mouse_position()))
		# Hook physics
	if $Chain.hooked:
		chain_velocity = to_local($Chain.tip).normalized() * CHAIN_STRENGH
		if chain_velocity.y > 0:
			chain_velocity.y *= 0.25
		else:
			chain_velocity.y *= .65
		if sign(chain_velocity.x) != sign(direction.x):
			chain_velocity.x *= 0.75
	else:
		chain_velocity = Vector2(0,0)
	velocity = velocity.move_toward(velocity + chain_velocity, 250)


func _process(delta: float) -> void:
	#print("VELOCITY X; ", velocity.x)
	#print("POSITION FROM PLAYER NODE: ", position)
	#print(direction)
	#print(on_wall)
	#print("on floor: ", is_on_floor())
	#print("time left: ", $Timers/WallJumpBuffer.time_left)
	#print(velocity.y)
	apply_grav(delta)

	if can_move:
		get_input()
		apply_movement(delta)
		apply_wall_friction()
		
		
	move_and_slide()
	update_face_direction()
	update_animation()

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_face_direction():
	if direction.x > 0:
		$PlayerSprite.flip_h = false
		sword_hitbox.scale.x = 1
	elif direction.x < 0:
		$PlayerSprite.flip_h = true
		sword_hitbox.scale.x = -1

func get_input():
	if character_state_machine.can_move():
		direction.x = Input.get_axis("left", "right")
		if direction != Vector2.ZERO:
			prev_direction.x = Input.get_axis("left", "right")
		
		if Input.is_action_just_pressed("jump"):
			# Can if one the floor or briefly if fall off cliff
			if is_on_floor() or $Timers/Movement/Coyote.time_left:
				jump =  true
		
			# if falling and not on the floor
			if velocity.y >= 0 and not is_on_floor():
				$Timers/Movement/JumpBuffer.start()
				
			# in on a wall
			if $Timers/Movement/WallJumpBuffer.time_left or is_on_wall():
				jump = true
		if Input.is_action_just_released("jump") and not is_on_floor() and velocity.y < 0:
			faster_fall = true
			
		if Input.is_action_just_pressed("dash") and velocity.x and GlobalS.grapple_enabled:
			#$PlayerModel/Dash.play("dash")
			dash = true
			#$PlayerModel/PlayerSprite.visible = false
			$Timers/Movement/DashVisibleTimer.start()


func apply_movement(delta: float):
	# vert movement
	if(direction.x and character_state_machine.can_move()):
		if(direction.x * velocity.x < 0): #opposite direction of current velocity
			acceleration = 3500
		else:
			acceleration = 900
		velocity.x = move_toward(velocity.x ,direction.x * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# jump movement
	if jump or ($Timers/Movement/JumpBuffer.time_left and is_on_floor()): 
		velocity.y -= jump_strengh
		jump = false
		faster_fall = false
		
	var on_floor = is_on_floor()
	move_and_slide()
	
	# player WAS on floor but now is not and is falling
	if on_floor and not is_on_floor() and velocity.y >= 0:
		$Timers/Movement/Coyote.start()
		
	if dash:
		dash = false
		var dash_tween = create_tween()
		dash_tween.tween_property(self, 'velocity:x', velocity.x + (prev_direction.x * 400), 0.1)
		dash_tween.connect("finished", on_dash_finish)

func apply_grav(delta: float):
	velocity.y += gravity * delta
	velocity.y = (3 * velocity.y) / 4  if faster_fall and velocity.y < 0 else velocity.y
	velocity.y = min(velocity.y, term_vel)

# NOTE: CHANGE HARD CODED VALUES LATER
func apply_wall_friction():

	if is_on_wall() and !on_wall:
		on_wall = true
		gravity = 0
		velocity.y = 0
		
		$Timers/Movement/WallFriction.start()
		
	elif !is_on_wall():
		if(on_wall):
			$Timers/Movement/WallJumpBuffer.start()
			on_wall = false
			gravity = GRAVITY_CONST


func _on_wall_friction_timeout():
	gravity =  move_toward(gravity ,GRAVITY_CONST, GRAVITY_CONST * .15)

# ATTACK LOGIC -> TO BE MOVED TO STATE MACHINE WHEN POSSIBLE

func on_dash_finish():
	pass
	#velocity.x = move_toward(velocity.x, 0, 500)

func _on_dash_visible_timer_timeout():
	#$PlayerModel/PlayerSprite.visible = true
	pass
