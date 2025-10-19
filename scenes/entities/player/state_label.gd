extends Label

@export var sm : CharacterStateMachine

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "State: " + sm.current_state.name
