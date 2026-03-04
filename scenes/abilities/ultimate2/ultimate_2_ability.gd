class_name Ultimate2Ability
extends Ability

@export var projectile_scene : PackedScene
@export var spawn_offset : Vector2 

## Tries to use the ability and returns
## if successful
func use(p_user : Node2D):
	var instance : Projectile = projectile_scene.instantiate()
	p_user.get_parent().add_child(instance)
	
	var direction_sign = signf(p_user.prev_direction.x) 
	#print("direction sign: ", direction_sign)
	var final_offset = Vector2(
		spawn_offset.x * direction_sign,
		spawn_offset.y
	)
	
	var instance_position = p_user.global_position + spawn_offset
	instance.global_position = instance_position
	instance.launch(p_user,  p_user.prev_direction)
	
	return true
