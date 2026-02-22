extends State
class_name playeridle


func enter():
	player.sprite.play("Idle")
	
func update(_delta : float) -> void:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		Transitioned.emit(self, "Walk")
		
	if Input.is_action_just_pressed("Attack"):
		Transitioned.emit(self, "Attack")
	
func physics_update(_delta: float) -> void:
	if player.get_real_velocity() == Vector2.ZERO:
		player.sprite.play("Idle")
