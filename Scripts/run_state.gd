extends State
class_name playerwalk


func exit() -> void:
	pass
	
func enter() -> void:
	player.sprite.play("Walk")

func update(_delta : float) -> void:
	#swaps to attack state even if moving if input is detected
	if Input.is_action_pressed("Attack"):
		Transitioned.emit(self, "Attack")
	#makes the sprite face whichever direction the player is moving/facing
	if player.velocity.x:
		player.sprite.flip_h = player.velocity.x < 0

func physics_update(_delta: float) -> void:
	
	#tweak later in order to account for "gravity"
	#if not is_on_floor():
	#	velocity += get_gravity() * _delta
	
	#gets the normalized vector in direction of player inpuits
	var movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var velocity = movement_direction * player.speed

	#switch to block state if the player presses block button
	if Input.is_action_just_pressed("Alt_Mouse"):
		Transitioned.emit(self, "Block")
	#switch to idle state if the velocity is 0
	if velocity == Vector2.ZERO:
		Transitioned.emit(self, "Idle")
	
	#assigns the velocity depending on the actual value of the vector itself
	player.velocity = velocity
	if velocity:
		player.velocity = player.velocity.move_toward(player.velocity, player.speed * _delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.baseFriction * _delta)
	player.move_and_slide()
