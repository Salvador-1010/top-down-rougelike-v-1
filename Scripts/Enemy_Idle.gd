extends State
class_name EnemyIdleState

@export var seek_radius := 30
var playerTracker : Node2D
var rand_vector 
var rand_radius
var rand_angle

func enter() -> void:
	entity.sprite.play("Idle")
	entity.pursueRadius.get_node("CollisionShape2D").shape.radius = seek_radius
	_create_vector()

func exit() -> void:
	pass

func update(_delta : float) -> void:
	print(entity.wander_raycast.is_colliding())

func physics_update(_delta: float) -> void:
	if entity.wander_wait_timer.is_stopped():
		pass

func _on_slime_pursue_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerTracker = body

func _create_vector() -> void:
	rand_angle = randf() * TAU
	rand_radius = sqrt(randf()) * seek_radius
	rand_vector = Vector2(cos(rand_angle), sin(rand_angle)) * rand_radius
	entity.wander_raycast.target_position = rand_vector
	if entity.wander_raycast.is_colliding():
		print("reran")
		_create_vector()
	


func _on_wander_wait_timer_timeout() -> void:
	print('hi')
