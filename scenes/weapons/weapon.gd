extends Node2D

@export var target: CharacterBody2D
@export var follow_speed: float = 2.75
@export var offset: Vector2 = Vector2(-40,0)

var prev_direction = Vector2.ZERO

func _ready():
	pass 


func _process(delta):
	if target:
		# will store the previous/current direciton of the character to 
		# determine where to move to
		var direction: Vector2 = target.direction
	
		#print("direciton: ", direction)
		if direction.x != 0:
			prev_direction = direction
		#print("pre direcitoN: ", prev_direction)

		if prev_direction.x > 0:
			position = position.lerp(offset, delta * follow_speed)
		if prev_direction.x < 0:
			position = position.lerp(offset.abs(), delta * follow_speed)
			#print("neg x, position + offset: ", target.position + offset.abs())
		#print("sword positioN: ", position)
