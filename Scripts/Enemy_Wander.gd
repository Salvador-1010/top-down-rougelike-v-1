extends State
class_name EnemeyWanderState

#var to track whether the enemy has already exited their wander radius once before
var has_exited : bool

func enter() -> void:
	entity.sprite.play("Walk")
	entity.wander_wait_timer.stop()
	
	#connects the area2d detection function
	entity.pursueRadius.body_entered.connect(_on_slime_pursue_radius_body_entered)

func exit() -> void:
	#disconnects the area2d detection function
	entity.pursueRadius.body_entered.disconnect(_on_slime_pursue_radius_body_entered)

func update(_delta : float) -> void:
	#sets the wander_dir every frame so that it will change the trajectory to always be on target and even 
	#if it runs into sometihng and is set off course it still tries to move to the target
	entity.wander_dir = (entity.wander_target_global - entity.global_position).normalized()
	#flips the facing node based on the sign of the x velocity
	#divides by abs value in order to just get the sign with magnitude 1 
	#fixed the conditional to work around the enemy velocity being 0
	if entity.velocity.x:
		entity.facing.scale.x = sign(entity.velocity.x)
	#finds the distance between the slimes pos (local to the slime scene) and the raycast target (local to slime scene
	#since the raycast is child of slime)
	if (entity.global_position-entity.initial_global_pos).distance_to(entity.wander_raycast.target_position) <= 1:
		Transitioned.emit(self, "Idle")
		

func physics_update(_delta: float) -> void:
	NavigationAgent2D.target_position = entity.wander_target_global
	#sets the raycast and wander radius global pos to the slimes initial global pos to ensure
	#it always stays within a specific radius
	entity.wander_raycast.global_position = entity.initial_global_pos
	entity.wander_radius.global_position = entity.initial_global_pos
	entity.wander_raycast.target_position = NavigationAgent2D.target_position
	#sets the slime to move in the normalized wander_direciton found in the idle state before the wander
	#state was called
	entity.velocity = entity.wander_dir * entity.enemy_speed
	entity.move_and_slide()

#if it detects the player enteres the pursue radius it switches to the pursue state
func _on_slime_pursue_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#assigns the tracker vector to the detected players current position minus the enemies current 
		#position in order to find the proper global position and then normalizes it 
		entity.player_tracker = (body.global_position - entity.global_position).normalized()
		entity.testray.target_position = (body.global_position - entity.global_position)
		Transitioned.emit(self,"Pursue")
