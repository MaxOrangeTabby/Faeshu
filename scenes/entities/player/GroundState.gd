extends State

var attacking : bool = false

@export_group('jump')
@export var jump_strengh: int = 350
@export var gravity: int = 600
@export var term_vel: int = 500

@export var air_state : State
@export var air_animation : String = "falling"

@export var attack_state : State
@export var attack_node : String = "attack_light2"

var wall_jump: bool = false
var faster_fall: bool = false

@export_group('dash')
@export var attack_dash: float = 100


	
func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
		
	if(event.is_action_pressed("primary_attack")):
		apply_attack()

func jump():
	next_state = air_state

func apply_attack():
	character.velocity.x = move_toward(character.velocity.x, 0, .1)
	next_state = attack_state
	
