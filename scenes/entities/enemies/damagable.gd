extends Node

class_name Damagable

signal on_hit(node : Node, damage_taken : int, knockback_dir : Vector2, is_crit : bool)

@export var health : float = 100 :
	get:
		return health
	set(value):
		health = value

@export var death_animation_name : String = "death"

func hit(damage : int, knockback_dir : Vector2, is_crit : bool):
	print("HIT")
	
	health -= damage
	SignalBus.emit_signal("on_health_changed", get_parent(), damage, is_crit)
	emit_signal("on_hit", get_parent(), damage, knockback_dir)
