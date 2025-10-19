extends Area2D

@export var base: float = 10
@export var energy_restore_amt : int = 10

var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	monitoring = true

func _on_body_entered(body):
	var crit_chance = randf()
	var r_mod = rng.randi_range(1, 10)
	var damage = base + r_mod
	
	var is_crit = crit_chance < .2
	if is_crit:
		damage *= 1.5
	
	print(body.name)
	for child in body.get_children():
		if child is Damagable and not child.is_in_group("Player"):
			if(GlobalS.energy_remaining < 100):
				GlobalS.energy_remaining += energy_restore_amt
			var direction_to_damagable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damagable)
			
			if(direction_sign.x > 0):
				child.hit(damage, Vector2.RIGHT, is_crit)
			elif(direction_sign.x < 0):
				child.hit(damage, Vector2.LEFT, is_crit)
			else:
				child.hit(damage, Vector2.ZERO, is_crit)
