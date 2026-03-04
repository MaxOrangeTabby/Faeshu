extends Enemy

var active: bool = false
@onready var player = get_tree().get_first_node_in_group("Player")

func _ready():
	health = 200 
	speed = 150  
	attack_speed = 1.2 
	weight_class = WeightClass.HEAVY
	attack_type = AttackType.MELEE

func _process(delta):
	if active:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_player_detection_area_body_entered(body):
	active = true
	print("detected")
