extends Node2D

@onready var links = $Links2

var player_position : Vector2
var direction := Vector2(0,0)
var tip := Vector2(0,0)

const HOOK_SPEED = 30

var flying = false	
var hooked = false	

# shoot() shoots the chain in a given direction
func shoot(dir: Vector2, player_pos : Vector2) -> void:
	player_position = player_pos
	direction = dir.normalized()
	flying = true
	tip = self.global_position 
	
	
func release() -> void:
	flying = false
	hooked = false

# Every graphics frame we update the visuals
func _process(_delta: float) -> void:
	self.visible = flying or hooked
	if not self.visible:
		return
	var tip_loc = to_local(tip)
	$Hook.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(90)

func _physics_process(_delta: float) -> void:
	#update_link()
	$Hook.global_position = tip	
	if flying:
		if $Hook.move_and_collide(direction * HOOK_SPEED):
			hooked = true
			flying = false
	tip = $Hook.global_position
#
#func update_link():
	#links.set_point_position(1, to_local(tip))
	#links.set_point_position(1, to_local(player_position))
