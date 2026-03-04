extends Area2D

var diag3_played : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && !diag3_played:
		diag3_played = true
		Dialogic.start('diag3')
		GlobalS.grapple_enabled = true
