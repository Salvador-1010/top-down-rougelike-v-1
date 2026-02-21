extends State
class_name playeridle

@export var player: CharacterBody2D
@export var playerAnimator: AnimatedSprite2D

func enter():
	playerAnimator.play("Idle")
	
func update(_delta : float) -> void:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		Transitioned.emit(self, "Walk")
		
	if Input.is_action_just_pressed("Attack"):
		Transitioned.emit(self, "Attack")
	
func physics_update(_delta: float) -> void:
	if player.get_real_velocity() == Vector2.ZERO:
		playerAnimator.play("Idle")
