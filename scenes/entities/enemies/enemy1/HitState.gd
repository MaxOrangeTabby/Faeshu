extends State

class_name HitState

@export var damagable : Damagable
@export var state_machine : CharacterStateMachine
@export var return_state: State
@export var dead_state: State
@export var dead_animation : String = "death"

@export var stagger_timer : Timer 

@export_group("Knockback")
@export var knockback_vel : float = 50
@export var knockup_vel : float = 50 

func _ready():
	damagable.connect("on_hit", on_damagable_hit)
	#stagger_timer.start()
	
func on_enter():
	character.velocity.x = knockback_vel
	
	
func on_damagable_hit(node : Node, damage_taken : int, knockback_dir : Vector2):
	print("enemy hp: ", damagable.health)
	if damagable.health > 0:
		emit_signal("interrupt_state", self)
		next_state = return_state
	else:
		playback.travel(dead_animation)


func _on_stagger_timer_timeout() -> void:
	next_state = return_state 
