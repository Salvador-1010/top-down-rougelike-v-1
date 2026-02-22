extends State
class_name playerattack2

#has a const attack buffer value in order to build scalability later on (ie maybe adding some window upgrades)
@export var attackbuffer_const = 0.15
var attackbuffer
var elapsed := 0.0

func enter() -> void:
	elapsed = 0.0
	#sets the attack buffer to the const + the length of the actual animations 
	#this way the buffer is applied AFTER the animation finished essentially
	attackbuffer = attackbuffer_const + (1/player.sprite.sprite_frames.get_animation_speed("Attack2") * player.sprite.sprite_frames.get_frame_count("Attack2"))
	player.sprite.play("Attack2")
	await player.sprite.animation_finished

func exit() -> void:
	pass

func update(_delta : float) -> void:
	pass

func physics_update(_delta: float) -> void:
	elapsed += _delta

	#if the animation finished and the buffer is over then the player goes back to idle
	if player.sprite.animation_finished and elapsed >= attackbuffer:
		Transitioned.emit(self, "Idle")
