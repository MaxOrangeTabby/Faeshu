extends Damagable


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == death_animation_name):
		get_parent().queue_free()
