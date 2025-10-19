class_name PlayerUseAbility
extends Node2D

@export var use_ability_action_name : String = "ultimate1"
@export var use_ability_action_name2 : String = "ultimate2"

@export var ultimate1 : Ability
@export var ultimate2 : Ability

@export var ultimate1_cost : int = 20
@export var ultimate2_cost : int = 40

@export var user : Node2D 



func _input(event: InputEvent) -> void:
	if (event.is_action_pressed(use_ability_action_name)):
		if (GlobalS.energy_remaining - ultimate1_cost) >= 0:
			GlobalS.energy_remaining -= ultimate1_cost
			ultimate1.use(user)
	elif (event.is_action_pressed(use_ability_action_name2)):
		if (GlobalS.energy_remaining - ultimate2_cost) >= 0:
			GlobalS.energy_remaining -= ultimate2_cost
			ultimate2.use(user)
