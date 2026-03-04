extends CanvasLayer

@onready var health_bar : TextureProgressBar = $MarginContainer/VBoxContainer/Bars/HealthBar
@onready var energy_bar : TextureProgressBar = $MarginContainer/VBoxContainer/Bars/EnergyBar
@onready var grapple_icon : TextureRect =  $MarginContainer/VBoxContainer/Icons/HBoxContainer/GrappleIcon
@onready var grrapple_btn_icon : TextureRect = $MarginContainer/VBoxContainer/Icons2/HBoxContainer/GrappleIcon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = GlobalS.health_remaining
	energy_bar.value = GlobalS.energy_remaining
	
	grapple_icon.visible = GlobalS.grapple_enabled
	grrapple_btn_icon.visible = GlobalS.grapple_enabled


	GlobalS.connect("health_change", update_health)
	GlobalS.connect("energy_change", update_energy)
	GlobalS.connect("grapple_status", enable_grapple_status)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_health():
	health_bar.value = GlobalS.health_remaining
	
func update_energy():
	energy_bar.value = GlobalS.energy_remaining


func enable_grapple_status():
	grapple_icon.visible = GlobalS.grapple_enabled
	grrapple_btn_icon.visible = GlobalS.grapple_enabled
