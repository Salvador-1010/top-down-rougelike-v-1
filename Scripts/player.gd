extends CharacterBody2D

@export var speed: float = 120.0

func _physics_process(_delta: float) -> void:
	# Get input as a 2D vector (WASD / arrows)
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Normalize so diagonals aren't faster
	velocity = input_dir * speed

	move_and_slide()
