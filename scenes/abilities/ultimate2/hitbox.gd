extends Area2D

@export var damage : float = 100

var targets_in_area : Array[Damagable]


var rng := RandomNumberGenerator.new()
	
func _ready():
	rng.randomize()
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	
func apply_damage(damage : float):
	var crit_chance = randf()
	var r_mod = rng.randi_range(1, 10)
	damage += r_mod
	var is_crit = crit_chance < .1
	
	for target in targets_in_area:
		if target != null:
			target.hit(damage, Vector2.ZERO, is_crit)

func _on_body_entered(hit_area : Node2D):
	for child in hit_area.find_children("", "Damagable"):
		if(child is Damagable && not targets_in_area.has(child)):
			#print("IN ULTIMATE:", child)
			targets_in_area.append(child)
	apply_damage(damage)
func _on_body_exited(hit_area : Node2D):
	for child in hit_area.find_children("", "Damagable"):
		if(child is Damagable && targets_in_area.has(child)):
			targets_in_area.erase(child)
