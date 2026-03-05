extends State
class_name EnemyIdleState

@export var seek_radius := 1.0
@export var max_attempts := 12
#@export var wait_time := 0.4

var is_wandering : bool
var destination_picked : bool

#gets the intial global positon to set it as a waypoint so that the calculated rand_vector offset it from the 
#original global origin rather than the origin after already wandering 
#(im doing this to prevent the enemy from wandering too far off from the area they were initially placed/spawned in
#var initial_pos 
#^^ replaced this var with a var that is stored in the slime characterbody2d script

#creates a varaible to store the global version of the rand vector created
var global_target

func enter() -> void:
	entity.sprite.play("Idle")
	#only ever sets the initial_pos once when the idle state is first called
	if entity.initial_global_pos == null:
		entity.initial_global_pos = entity.global_position
	#sets the pursue radius to whatever was set in the inspector 
	entity.pursueRadius.get_node("CollisionShape2D").shape.radius = seek_radius
	#set is_wandering to false by default
	is_wandering = false

	
	#sets the wander_dir to zero on entering so that the check in physics process wont run until the timernode is done
	entity.wander_dir = Vector2.ZERO
	
	#starts the timer with the intial wait time that was set on the timer node
	entity.wander_wait_timer.start()

func exit() -> void:
	pass

func update(_delta : float) -> void:
	print(entity.wander_wait_timer.wait_time)
	if entity.wander_dir == Vector2.ZERO:
		return
	else:
		Transitioned.emit(self, "Wander")
		
func physics_update(_delta: float) -> void:
	pass

func _on_wander_wait_timer_timeout() -> void:
	#sets the next wait length to a rand float 
	entity.wander_wait_timer.wait_time = randf_range(1.0, 3.0)
	
	#since the timer ran out, its time for the slime to wander 
	is_wandering = true
	
	#calls the function to run the logic to get the slimes direction
	_get_dir()

#returns an offset vector of the initial global pos
func _get_rand_vector() -> Vector2:
	var rand_angle = randf() * TAU
	var rand_radius = sqrt(randf()) * seek_radius
	var rand_vector = Vector2(cos(rand_angle), sin(rand_angle)) * rand_radius
	destination_picked = true
	return rand_vector

func _get_dir():
	global_target = _get_rand_vector() + entity.initial_global_pos
	
	entity.wander_dir = (global_target - entity.global_position).normalized()
	entity.wander_raycast.target_position = global_target - entity.initial_global_pos
	
	#start of code to check if the slime can even go where intended
	if _is_path_clear(entity.global_position, entity.wander_raycast.target_position):
		pass

func _is_path_clear(current_location: Vector2, target_location: Vector2) -> bool:
	return false
