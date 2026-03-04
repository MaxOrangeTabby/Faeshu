extends State

@export var dead_animation : String = "death"
@export var damagable : Damagable

func on_enter():
	if damagable.health <= 0:
		character.queue_free()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	emit_signal("interrupt_state", self)
