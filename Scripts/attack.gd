extends State
class_name playerattack

@export var damage: float
@export var combo_window: float

#creates an exportable friction variable to apply when the player is trying to move while attacking
@export var movingFrictionPerc_Attack1 : float
@export var movingSpeedPerc_Attack1: float
#declares the variable to store the NEW attacking friction
#making it a certain percantage of the base friction so that later on maybe i can add scalability and
#allow for later upgrades to improve mobility while attacking?

var combo_queued := false
var elapsed := 0.0

var window_start = 0
var window_end = 0

func enter() -> void:
	elapsed = 0.0
	combo_queued = false
	#player.velocity = Vector2.ZERO
	player.sprite.play("Attack")
	player.sprite.animation_finished.connect(transition)
	
	#calculates the length of each frame using the animation fps
	var frame_time = 1/player.sprite.sprite_frames.get_animation_speed("Attack")
	#calculates the combow window from the actual timestamps of the specific frames (between frames 3 and 5)
	window_start = (3) * frame_time
	window_end = (5 + 1) * frame_time
	
func exit() -> void:
	#disconnects the animation signal to avoid any errors
	if player.sprite.animation_finished.is_connected(transition):
		player.sprite.animation_finished.disconnect(transition)
	
func update(_delta : float) -> void:
	#makes the sprite face whichever direction the player is moving/facing
	if player.velocity.x:
		player.sprite.flip_h = player.velocity.x < 0
	
func physics_update(_delta: float) -> void:
	#stores the elapsed time to see if the player queued another attack before the window closed
	elapsed += _delta
	#makes sure that the attack was queued DURING the combow window and an attack hasnt already been queued
	if (window_start < elapsed and elapsed < window_end) and !combo_queued and Input.is_action_just_pressed("Attack"):
		combo_queued = true
	
	#gets the normalized vector in direction of player inpuits
	var movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player.velocity = movement_direction * player.speed * movingSpeedPerc_Attack1
	
	#code to allow the character to move even while the attack animation is going 
	if player.velocity:
		player.velocity = player.velocity.move_toward(player.velocity, player.speed * _delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.baseFriction * _delta)
	player.move_and_slide()
	
	#makes sure that the attack1 animation actually finishes before moving on 
	await player.sprite.animation_finished
	#if the animation that finished playing is Attack1 then transition to attack2
	if player.sprite.animation == "Attack":
		Transitioned.emit(self, "Attack2")

func transition() -> void:
	#checks to make sure that the finished animation was the attck so we can go back to idle
	#if there was no combo queued then itll return to idle
	if player.sprite.animation == "Attack" and !combo_queued:
		Transitioned.emit(self, "Idle")
