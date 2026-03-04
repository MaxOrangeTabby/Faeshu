extends State

@export var ground_state : State
@export var ground_animation : String = "Move"

@export var wall_state : State
@export var wall_animation : String = "wall_hug"

@export var fall_animation : String = "falling"


func state_input(event : InputEvent):
	if(event.is_action_released("jump")):
		playback.travel(fall_animation)


func state_process(delta):
	if(character.is_on_floor()):
		next_state = ground_state
		playback.travel(ground_animation)
	elif(!character.is_on_floor() and character.is_on_wall()):
		playback.travel(wall_animation)
		next_state = wall_state

func _ready():
	print("AIR!")
