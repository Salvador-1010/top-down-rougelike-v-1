extends State
class_name PursueState

func enter() -> void:
	entity.sprite.play("Move")
	print("trans")
func exit() -> void:
	pass

func update(_delta : float) -> void:
	#checks to see if the player is STILL in the area2d and if it is, it uses its realtime position for the tracker
	#in hindsight there probably is a much MUCH better way to do this that is less stinky and plus this probabyl would
	#build horribly if i ever want to implement multiple players but its V1 so just something to consider
	for bodies in entity.pursueRadius.get_overlapping_bodies():
		if bodies.is_in_group("Player"):
			entity.player_tracker = (bodies.global_position - entity.global_position).normalized()
			entity.testray.target_position = (bodies.global_position - entity.global_position)
	entity.facing.scale.x = entity.velocity.x/abs(entity.velocity.x)

func physics_update(_delta: float) -> void:
	entity.velocity = entity.player_tracker * entity.enemy_speed
	entity.move_and_slide()
