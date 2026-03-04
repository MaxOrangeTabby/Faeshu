extends Control

@export var health_changed_label : PackedScene
@export var damage_color : Color = Color.RED
@export var heal_color : Color = Color.GREEN
@export var crit_color : Color = Color("#E9D758")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_signal_health_changed(node : Node, amount_changed : int, is_crit : bool):
	var label_instance : Label = health_changed_label.instantiate()
	node.add_child(label_instance)
	label_instance.position.y -= 40
	label_instance.text = str(amount_changed)

	if is_crit:
		label_instance.modulate = crit_color
		label_instance.text = str("CRIT: ", amount_changed)

	else:
		label_instance.modulate = damage_color
