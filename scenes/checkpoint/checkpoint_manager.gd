extends Node2D

var prev_location : Vector2
@export var player : CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalS.connect("health_change", check_player_status)
	#player = get_parent().get_node("Player")
	prev_location = player.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check_player_status():
	if GlobalS.health_remaining <= 0:
		player.position = prev_location
		GlobalS.health_remaining = 100
	
