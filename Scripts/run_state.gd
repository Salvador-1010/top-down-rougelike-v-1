extends State
class_name playerwalk

@export var speed: float
@export var player: CharacterBody2D
@export var playerAnimator: AnimatedSprite2D
@export var friction: float

func exit() -> void:
	pass
	
func enter() -> void:
	playerAnimator.play("Walk")

func update(_delta : float) -> void:
	
	if player.velocity.x:
		playerAnimator.flip_h = player.velocity.x < 0

func physics_update(_delta: float) -> void:
	
	#tweak later in order to account for "gravity"
	#if not is_on_floor():
	#	velocity += get_gravity() * _delta
	
	#gets the normalized vector in direction of player inpuits
	var movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var velocity = movement_direction * speed

	#switch to idle state if the velocity is 0
	if velocity == Vector2.ZERO:
		Transitioned.emit(self, "Idle")
	
	#assigns the velocity depending on the actual value of the vector itself
	player.velocity = velocity
	if velocity:
		player.velocity = player.velocity.move_toward(player.velocity, speed * _delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, friction * _delta)
	player.move_and_slide()
