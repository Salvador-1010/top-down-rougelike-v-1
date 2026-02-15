extends CharacterBody2D

@export var speed := 125.0
@export var accel := 1500.0
@export var friction := 1000.0

func _physics_process(delta):
	var input_dir := Input.get_vector("move_left","move_right","move_up","move_down")
	var target_vel := input_dir * speed

	if input_dir != Vector2.ZERO:
		velocity = velocity.move_toward(target_vel, accel * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
