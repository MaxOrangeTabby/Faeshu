extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("Player")

var attacking: bool = false
@export var speed : float = 100
@export var gravity : float = 150
@export var direction : Vector2 = Vector2(-1,0)
@export var damagable : Damagable
@export var BulletScene: PackedScene 

@onready var enemy_sprite : Sprite2D = $Sprite2D
@onready var anim_player = $AnimationPlayer

func _ready():
	pass
	
func _process(delta):
	velocity.y += gravity * delta
	velocity.x = direction.x * speed
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
	if position.distance_to(player.position) < 200:
		attacking = true
		speed = 0
	else:
		attacking = false
		speed = 100

func handle_anim():
	$Sprite2D.flip_h = direction.x > 0
	if damagable.health <= 0:
		$AnimationPlayer.current_animation = "death"
	elif attacking:
		if not $Bullet_buffer.time_left:
			shoot_bullet()
			var diff = (player.position - position).normalized()
			$Sprite2D.flip_h = diff.x > 0
			$AnimationPlayer.current_animation = "attack"
	else:
		$AnimationPlayer.current_animation = "walk"
	

func shoot_bullet():
	if not $Bullet_buffer.time_left:
		$Bullet_buffer.start()
		var bullet_instance = BulletScene.instantiate()
		
		if(direction.x > 0):
			bullet_instance.global_position = global_position
			bullet_instance.global_position.x += 40
		else:
			bullet_instance.global_position = global_position 
			bullet_instance.global_position.x -= 40

		get_parent().add_child(bullet_instance)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()
