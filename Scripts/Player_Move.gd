extends State
class_name playerwalk


func exit() -> void:
	pass
	
func enter() -> void:
	entity.sprite.play("Walk")

func update(_delta : float) -> void:
	#swaps to attack state even if moving if input is detected
	if Input.is_action_pressed("Attack"):
		Transitioned.emit(self, "Attack")
	#makes the sprite face whichever direction the player is moving/facing
	if entity.velocity.x:
		#changed the logic from the previous one because now instead i am just flipping an entire 2dnode in order
		#to flip mult things at once so i just find the velocity and divide it by the magnitude to get
		#either -1 or 1 (there could be a better way to do this like some normalizing function but i tried
		#to use normalized().x but that didnt work)
		entity.facing.scale.x = entity.velocity.x/abs(entity.velocity.x)
		#entity.sprite.flip_h = entity.velocity.x < 0

func physics_update(_delta: float) -> void:
	
	#tweak later in order to account for "gravity"
	#if not is_on_floor():
	#	velocity += get_gravity() * _delta
	
	#gets the normalized vector in direction of player inpuits
	var movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var velocity = movement_direction * entity.speed

	#switch to block state if the player presses block button
	if Input.is_action_just_pressed("Alt_Mouse"):
		Transitioned.emit(self, "Block")
	#switch to idle state if the velocity is 0
	if velocity == Vector2.ZERO:
		Transitioned.emit(self, "Idle")
	
	#assigns the velocity depending on the actual value of the vector itself
	entity.velocity = velocity
	if velocity:
		entity.velocity = entity.velocity.move_toward(entity.velocity, entity.speed * _delta)
	else:
		entity.velocity = entity.velocity.move_toward(Vector2.ZERO, entity.baseFriction * _delta)
	entity.move_and_slide()
