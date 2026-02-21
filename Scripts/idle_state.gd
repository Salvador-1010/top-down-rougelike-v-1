extends State
class_name playeridle

@export var player: CharacterBody2D
@export var playerAnimator: AnimatedSprite2D

func enter():
	pass
	
func update(_delta : float) -> void:
	if player.velocity != Vector2.ZERO:
		Transitioned.emit("Idle", "Walk")
	
func physics_update(_delta: float) -> void:
	if player.get_real_velocity() == Vector2.ZERO:
		playerAnimator.play("Idle")
		
