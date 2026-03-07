extends State
class_name EnemeyWanderState

#var to track whether the enemy has already exited their wander radius once before
var has_exited : bool

func enter() -> void:
	entity.sprite.play("Walk")
	entity.wander_wait_timer.stop()

func exit() -> void:
	pass

func update(_delta : float) -> void:
	#sets the wander_dir every frame so that it will change the trajectory to always be on target and even 
	#if it runs into sometihng and is set off course it still tries to move to the target
	entity.wander_dir = (entity.wander_target_global - entity.global_position).normalized()
	#flips the facing node based on the sign of the x velocity
	#divides by abs value in order to just get the sign with magnitude 1 
	entity.facing.scale.x = entity.velocity.x/abs(entity.velocity.x)
	#finds the distance between the slimes pos (local to the slime scene) and the raycast target (local to slime scene
	#since the raycast is child of slime)
	if (entity.global_position-entity.initial_global_pos).distance_to(entity.wander_raycast.target_position) <= 1:
		Transitioned.emit(self, "Idle")
		

func physics_update(_delta: float) -> void:

	#sets the raycast and wander radius global pos to the slimes initial global pos to ensure
	#it always stays within a specific radius
	entity.wander_raycast.global_position = entity.initial_global_pos
	entity.wander_radius.global_position = entity.initial_global_pos
	
	#sets the slime to move in the normalized wander_direciton found in the idle state before the wander
	#state was called
	entity.velocity = entity.wander_dir * entity.enemy_speed
	entity.move_and_slide()


	
