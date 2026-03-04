extends Area2D

@export var sound_player : AudioStreamPlayer
@export var CheckpointManager : Node2D
@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		CheckpointManager.prev_location = player.global_position
		sound_player.play()
		GlobalS.health_remaining += 20
		queue_free()
