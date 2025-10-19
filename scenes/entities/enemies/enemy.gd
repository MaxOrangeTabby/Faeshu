class_name Enemy
extends CharacterBody2D 

enum WeightClass { LIGHT, MEDIUM, HEAVY }
enum AttackType { MELEE, MID_RANGED, RANGED }

@export var weight_class: WeightClass = WeightClass.MEDIUM
@export var attack_type: AttackType = AttackType.MELEE

@export var health: float = 0.0
@export var speed: float = 0.0
@export var attack_speed: float = 0.0

func handle_damage(damage_value: float):
	health -= damage_value
	if health <= 0:
		death()
	pass

# TO OVERRIDE
func handle_knockback():
	pass

# TO OVERRIDE
func death():
	pass
