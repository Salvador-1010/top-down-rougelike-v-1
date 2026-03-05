extends State
class_name EnemeyWanderState


func enter() -> void:
	entity.sprite.play("Walk")
	entity.wander_wait_timer.stop()

func exit() -> void:
	pass

func update(_delta : float) -> void:
	#flips the facing node based on the sign of the x velocity
	#divides by abs value in order to just get the sign with magnitude 1 
	entity.facing.scale.x = entity.velocity.x/abs(entity.velocity.x)
	#finds the distance between the slimes pos (local to the slime scene) and the raycast target (local to slime scene
	#since the raycast is child of slime)
	if (entity.global_position-entity.initial_global_pos).distance_to(entity.wander_raycast.target_position) <= 1:
		print("trans")
		Transitioned.emit(self, "Idle")

func physics_update(_delta: float) -> void:
	entity.wander_raycast.global_position = entity.initial_global_pos
	entity.velocity = entity.wander_dir * entity.enemy_speed
	entity.move_and_slide()
