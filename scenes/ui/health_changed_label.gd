extends Label

@export var float_speed : float = 120

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $SpeedStop.time_left:
		position.x += float_speed * delta

func _on_timer_timeout():
	queue_free()
