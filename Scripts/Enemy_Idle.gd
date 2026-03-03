extends State
class_name EnemyIdleState

@export var seek_radius := 1.0
@export var max_attempts := 12
@export var wait_time := 0.4

var is_wandering : bool
var destination_picked : bool

#gets the intial global positon to set it as a waypoint so that the calculated rand_vector offset it from the 
#original global origin rather than the origin after already wandering 
#(im doing this to prevent the enemy from wandering too far off from the area they were initially placed/spawned in
var initial_pos 

func enter() -> void:
	entity.sprite.play("Idle")
	#only ever sets the initial_pos once when the idle state is first called
	if initial_pos == null:
		initial_pos = entity.global_position
	#sets the pursue radius to whatever was set in the inspector 
	entity.pursueRadius.get_node("CollisionShape2D").shape.radius = seek_radius
	#set is_wandering to false by default
	is_wandering = false
	#sets the destination tracker to false by default
	destination_picked = false
	
	#sets the wandering wait timer to whatever was set in the inspector for idle state and then starts the timer
	entity.wander_wait_timer.wait_time = wait_time
	entity.wander_wait_timer.start()

func exit() -> void:
	pass

func update(_delta : float) -> void:
	print(initial_pos, " ", entity.global_position)
	
	#checks if the enemy is supposed to be wandering
	#also checks that the wander wait timer is stopped (ie the player is on the move)
	#finally makes sure that the _get_rand_vector() function hasnt already ran 
	#^ to avoid pikcing more vectors while moving to the first rand vector returned
	#there probably is a better way to check for the last one but its ok i think it gets the job done
	if is_wandering and entity.wander_wait_timer.is_stopped() and !destination_picked:
		print(_get_rand_vector())
func physics_update(_delta: float) -> void:
	pass

func _on_wander_wait_timer_timeout() -> void:
	#sets the next wait length to a rand float 
	entity.wander_wait_timer.wait_time = randf_range(2.0, 3.5)
	#stops the timer so that it will not begin counting down again until the rand wander destination is met
	entity.wander_wait_timer.stop()
	is_wandering = true
	destination_picked = false


func _get_rand_vector() -> Vector2:
	var rand_angle = randf() * TAU
	var rand_radius = sqrt(randf()) * seek_radius
	var rand_vector = Vector2(cos(rand_angle), sin(rand_angle)) * rand_radius
	destination_picked = true
	return rand_vector
