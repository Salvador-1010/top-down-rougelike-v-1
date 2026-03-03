extends State
class_name EnemyIdleState

@export var seek_radius := 60.0
@export var max_attempts := 12
@export var wait_time := 0.4

func enter() -> void:
	entity.sprite.play("Idle")
	entity.wander_wait_timer.start(wait_time)

func physics_update(_delta: float) -> void:
	# wait first (optional)
	if not entity.wander_wait_timer.is_stopped():
		return

	# pick a valid target
	var target := _pick_valid_wander_target()
	if target != null:
		entity.wander_target_global = target
		Transitioned.emit(self, "Wander")
	else:
		# couldn't find a target, just wait again
		entity.wander_wait_timer.start(wait_time)

func _pick_valid_wander_target() -> Variant:
	for i in range(max_attempts):
		var offset = _random_point_in_circle(seek_radius)
		var candidate_global = entity.global_position + offset

		if _path_blocked(entity.global_position, candidate_global):
			continue

		return candidate_global

	return null

func _random_point_in_circle(r: float) -> Vector2:
	var ang = randf() * TAU
	var rad = sqrt(randf()) * r
	return Vector2(cos(ang), sin(ang)) * rad

func _path_blocked(from_global: Vector2, to_global: Vector2) -> bool:
	# RayCast2D expects local target from its own origin
	var rc: RayCast2D = entity.wander_raycast
	rc.global_position = from_global
	rc.target_position = rc.to_local(to_global)
	rc.force_raycast_update()
	return rc.is_colliding()
