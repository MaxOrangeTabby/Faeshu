extends Node




func _on_ultimate_2_timeout_timeout() -> void:
	get_parent().queue_free()
