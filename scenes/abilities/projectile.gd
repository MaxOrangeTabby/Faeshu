class_name Projectile
extends CharacterBody2D 

@export var gravity : float  =  200

var direction = Vector2.ZERO
var source : Node
var spawned = false
@onready var player_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	call_deferred("_validate_setup")

func _physics_process(delta: float) -> void:
	velocity.y = move_toward(velocity.y, 2500, 500)
	move_and_slide()
	
func launch(param_source : Node, param_direction : Vector2) :
	source = param_source
	direction = param_direction
	if direction.x < 0:
		player_sprite.flip_h = true
	elif direction.x > 0:
		player_sprite.flip_h = false
	
func _validate_setup(): 
	var no_issue = true
	
	if(spawned == false):
		print("created ultimate but not launched")
		no_issue = false
		
	return no_issue
