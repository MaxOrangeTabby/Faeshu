extends Area2D


var checkpoint_manager : Node2D
@export var player : CharacterBody2D



func _ready() -> void:
	checkpoint_manager = get_parent().get_parent().get_node("CheckpointManager")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		kill_player()

func kill_player():
	player.position = checkpoint_manager.prev_location
