extends State
class_name playeridle


func enter():
	player.sprite.play("Idle")
	
func update(_delta : float) -> void:
	#if movement input is detected, switches to that state
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		Transitioned.emit(self, "Walk")
		
	#if the player click the attack button, switch to that state
	if Input.is_action_just_pressed("Attack"):
		Transitioned.emit(self, "Attack")
	
	#if the player clicks the block button, switches to that state
	if Input.is_action_just_pressed("Alt_Mouse"):
		Transitioned.emit(self, "Block")
	
func physics_update(_delta: float) -> void:
	if player.get_real_velocity() == Vector2.ZERO:
		player.sprite.play("Idle")
