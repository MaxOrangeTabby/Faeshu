extends Node

class_name State

@export var can_move : bool = true
@export var death_animation_name = "death"

var character : CharacterBody2D
var direction : Vector2 
var next_state : State
var playback : AnimationNodeStateMachinePlayback

signal interrupt_state(new_state : State)

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass
	
