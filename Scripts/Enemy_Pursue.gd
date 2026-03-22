extends State
class_name PursueState
var initial_speed = 0
var initial_radius = 0
#stores the last updated postion of the enemy when they were in the radius
var last_enemy_pos = Vector2.ZERO
#stores whether the player is currently in the radius
var enemy_inside := false


func enter() -> void:
	#stores the intial, unchanged speed and radius
	initial_speed = entity.enemy_speed
	initial_radius = entity.pursueRadius.get_node("CollisionShape2D").shape.radius
	entity.sprite.play("Move")
	#expands the enemies pursue radius 
	entity.pursueRadius.get_node("CollisionShape2D").shape.radius *=2.25
	#increases the enemies speed shortly
	entity.enemy_speed *= 2
func exit() -> void:
	entity.enemy_speed = initial_speed
	entity.pursueRadius.get_node("CollisionShape2D").shape.radius = initial_radius

func update(_delta : float) -> void:
	#checks to see if the player is STILL in the area2d and if it is, it uses its realtime position for the tracker
	#in hindsight there probably is a much MUCH better way to do this that is less stinky and plus this probabyl would
	#build horribly if i ever want to implement multiple players but its V1 so just something to consider
	for bodies in entity.pursueRadius.get_overlapping_bodies():
		if bodies.is_in_group("Player"):
			enemy_inside = true
			entity.pursue_timer.start()
			last_enemy_pos = bodies.global_position
			entity.player_tracker = (bodies.global_position - entity.global_position).normalized()
			entity.testray.target_position = (bodies.global_position - entity.global_position)
		else:
			enemy_inside = false
	entity.facing.scale.x = entity.velocity.x/abs(entity.velocity.x)

func physics_update(_delta: float) -> void:
	if !enemy_inside and (entity.global_position.distance_to(last_enemy_pos) < 1):
		print("not")
		entity.velocity.move_toward(Vector2.ZERO,_delta)
	else:
		entity.velocity = entity.player_tracker * entity.enemy_speed
		entity.move_and_slide()

#when the timer runs it, it makes the enemy go back to idling since the player "got away"
func _on_pursue_timer_timeout() -> void:
	pass
	#Transitioned.emit(self, "Idle")
#NOTE: slime stops immedialty rn but it wuold be nice to maybe add a cool like "confused" animation/slowdown later on
