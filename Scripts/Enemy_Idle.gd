extends State
class_name EnemyIdleState

@export var seek_radius := 30
var playerTracker : Node2D


func enter() -> void:
	entity.sprite.play("Idle")
	entity.pursueRadius.get_node("CollisionShape2D").shape.radius = seek_radius

func exit() -> void:
	pass

func update(_delta : float) -> void:
	print(playerTracker)

func physics_update(_delta: float) -> void:
	pass

func _on_slime_pursue_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerTracker = body
