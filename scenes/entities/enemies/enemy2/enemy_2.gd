extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("Player")

var attacking: bool = false
@export var speed : float = 40
@export var gravity : float = 150
@export var direction : Vector2 = Vector2(-1,0)
@export var damagable : Damagable

@onready var enemy_sprite : Sprite2D = $Sprite2D
@onready var anim_player = $AnimationPlayer


var damage : float = 15

func _ready():
	pass
	
func _process(delta):
	#print(direction.x)
	#print($Hitbox.monitoring)
	velocity.y += gravity * delta
	velocity.x = direction.x * speed
	process_hitbox()
	check_cliff()
	player_near()
	handle_anim()
	move_and_slide()

func check_cliff():
	if direction.x > 0 and not $Raycasts/RRay.get_collider():
		direction.x = -1
	elif direction.x < 0  and not $Raycasts/LRay.get_collider():
		direction.x = 1

func player_near():
	if position.distance_to(player.position) < 60:
		attacking = true
		speed = 0
	else:
		attacking = false
		speed = 15

func handle_anim():
	$Sprite2D.flip_h = direction.x > 0
	if damagable.health <= 0:
		$AnimationPlayer.current_animation = "death"
	elif attacking:
		
		var diff = (player.position - position).normalized()
		$Sprite2D.flip_h = diff.x > 0
		if diff.x != 0:
			direction.x = int(diff.x > 0)
			if(direction.x == 0):
				direction.x = -1

		$AnimationPlayer.current_animation = "attack"
	else:
		$AnimationPlayer.current_animation = "walk"
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()
		
func process_hitbox():
	if direction.x > 0:
		$Hitbox/RHitbox.disabled = false
		$Hitbox/LHitbox.disabled = true

	elif direction.x < 0:
		$Hitbox/LHitbox.disabled = false
		$Hitbox/RHitbox.disabled = true


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#print("HIT PLAYER")
		GlobalS.health_remaining = GlobalS.health_remaining -  damage
