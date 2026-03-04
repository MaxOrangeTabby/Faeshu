extends Area2D

var diag2_played : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && !diag2_played:
		diag2_played = true
		Dialogic.start('diag2')
