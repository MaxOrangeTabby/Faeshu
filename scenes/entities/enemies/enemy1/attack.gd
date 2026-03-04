extends State

@onready var player = get_tree().get_first_node_in_group("Player")
@export var walk_state : State

@export var attack_animation : String = "attack"
@export var walk_animation : String = "walk"

@onready var attack_buffer : Timer = $attack_buffer
@export var damage : float = 5


func _on_attack_buffer_timeout() -> void:
	next_state = walk_state
	playback.travel(walk_animation)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == attack_animation:
		GlobalS.health_remaining -= damage
		attack_buffer.start()
