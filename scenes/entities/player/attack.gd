extends State


@export var return_state: State
@onready var return_animation : String = "Move"

@export var attack_light2 : String = "attack_light2"
@export var attack_light3 : String = "attack_light3"
@export var attack_heavy1 : String = "attack_heavy1"

@onready var attack_light_buffer : Timer = $attack_light_buffer
@onready var attack_light_buffer2 : Timer = $attack_light_buffer2

@onready var attack_light_timeout : Timer = $attack_light_timeout
@onready var attack_dash_timer : Timer = $attack_dash_timer

@export var attack_dash : float = 140

@onready var attack_light1_fx = $"../../SoundFX/LightAttack1"
@onready var attack_light2_fx = $"../../SoundFX/LightAttack2"
@onready var attack_heavy_fx = $"../../SoundFX/HeavyAttack"


func state_input(event : InputEvent):
	#if(event.is_action_pressed("primary_attack")):
	character.move_and_slide()
		##attack_light_buffer.start()

func on_enter():
	
	if attack_light_buffer.time_left:
		trigger_attack_lurch()
		attack_light2_fx.play()
		playback.travel(attack_light3)
		
		attack_light_buffer.stop()
		attack_light_buffer2.start()
	elif attack_light_buffer2.time_left:
		trigger_attack_lurch()
		playback.travel(attack_heavy1)
		attack_heavy_fx.play()

		
		attack_light_buffer2.stop()
	else:
		trigger_attack_lurch()
		playback.travel(attack_light2)
		attack_light2_fx.play()
		attack_light_buffer.start()


	attack_light_timeout.start()


func _on_attack_light_timeout_timeout() -> void:
	#character.velocity.x = 0
	next_state = return_state
	playback.travel(return_animation)
	
func trigger_attack_lurch() -> void:
	if(character.prev_direction.x > 0):
		character.velocity.x = move_toward(character.velocity.x, attack_dash, 140)
	elif(character.prev_direction.x < 0):
		character.velocity.x = move_toward(character.velocity.x, -attack_dash, 140)
