extends Node2D

@export var player : CharacterBody2D
var intro_diag_played : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if not intro_diag_played:
		intro_diag_played = true
		get_viewport().set_input_as_handled()
		Dialogic.start('intro_diag')
		#pause_player()

#func pause_player():
	#player.set_process(false)  
	#player.set_physics_process(false)   
	#player.set_process_input(false)      
	#player.set_process_unhandled_input(false)
