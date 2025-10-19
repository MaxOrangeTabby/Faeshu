extends State

@export var attack_state : State
@onready var player = get_tree().get_first_node_in_group("Player")
@export var attack_animation : String = "attack"
@export var damage: float = 5


var colliding_player = false
var target_in_range = []

func _process(delta: float) -> void:
	if target_in_range.size() > 0:
		attack_player()

func _on_player_hit_range_body_entered(body: Node2D) -> void:
	#print("body entered")
	colliding_player = true
	for child in body.get_children():
		if child.is_in_group("Player"):
				target_in_range.append(child)



func attack_player():
	character.velocity.x = 0
	next_state = attack_state
	playback.travel(attack_animation)


func _on_player_hit_range_body_exited(body: Node2D) -> void:
	colliding_player = false
	for child in body.get_children():
		if child.is_in_group("Player"):
				target_in_range.erase(child)
