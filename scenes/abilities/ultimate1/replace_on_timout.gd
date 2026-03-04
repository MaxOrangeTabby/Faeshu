extends Node

@export var enter_area : Area2D



func _on_utimate_1_timeout_timeout() -> void:
	get_parent().queue_free()
