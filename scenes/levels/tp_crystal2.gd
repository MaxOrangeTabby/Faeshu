extends Area2D


var end_scene : PackedScene = preload("res://scenes/ui/end_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().call_deferred("change_scene_to_packed", end_scene)
