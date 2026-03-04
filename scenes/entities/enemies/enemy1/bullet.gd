extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")

var accel : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var damage : float = 10

func _ready() -> void:
	$bullet_lifetime.start()

func _physics_process(delta: float) -> void:
	accel = (player.position - position).normalized() * 500
	velocity += accel * delta
	rotation = velocity.angle()
	
	velocity = velocity.limit_length(150)
	position += velocity * delta
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("HIT PLAYER")
		GlobalS.health_remaining = GlobalS.health_remaining -  damage
	queue_free()


func _on_bullet_lifetime_timeout() -> void:
	queue_free()
