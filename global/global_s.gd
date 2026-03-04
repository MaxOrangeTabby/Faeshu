extends Node

signal health_change
signal energy_change
signal grapple_status
signal ultimate1_status
signal ultimate2_status


var grapple_enabled : bool = false:
	get:
		return grapple_enabled
	set(new_grapple_status):
		grapple_enabled = new_grapple_status
		grapple_status.emit()

var ultimate1_enabled : bool = false:
	get:
		return ultimate1_enabled
	set(new_ult1_status):
		ultimate1_enabled = new_ult1_status
		ultimate1_status.emit()

var ultimate2_enabled : bool = false:
	get:
		return ultimate2_enabled
	set(new_ult2_status):
		ultimate2_enabled = new_ult2_status
		ultimate2_status.emit()

var health_remaining : float = 100:
	get:
		return health_remaining
	set(new_hp):
		health_remaining = new_hp
		health_change.emit()

var energy_remaining : float = 100:
	get:
		return energy_remaining
	set(new_energy_val):
		energy_remaining = new_energy_val
		energy_change.emit()
