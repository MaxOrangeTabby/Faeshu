extends Projectile

var player_direction : Vector2
var dash_velocity : float = 2500
var dash_velocity_falloff : float = 1000
var has_dashed = false


func _physics_process(delta: float) -> void:
	#print("direction: ", direction)

	if not has_dashed:
		has_dashed = true
		if direction.x < 0:
			player_sprite.flip_h = true
			velocity.x = -dash_velocity
		elif direction.x > 0:
			player_sprite.flip_h = false
			velocity.x = dash_velocity
		var dash_tween = create_tween()
		dash_tween.tween_property(self, "velocity", Vector2(0, velocity.y), 0.215)
	move_and_slide()
