extends State

@export var air_state : State
@export var ground_state : State

@export var return_animation : String = "Move"

func state_process(delta):
	if(!character.is_on_wall() and (!character.is_on_floor())):
		next_state = air_state
		playback.travel(return_animation)
	elif((!character.is_on_wall()) and (character.is_on_floor())):
		next_state = ground_state
		playback.travel(return_animation)
