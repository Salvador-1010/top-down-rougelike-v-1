extends State
class_name playerwalk

@export var speed: float
@export var player: CharacterBody2D
@export var playerAnimator: AnimatedSprite2D

func exit() -> void:
	pass
	
func enter() -> void:
	pass

func update(_delta : float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if player.velocity == Vector2.ZERO:
		print("hello")
