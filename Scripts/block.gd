extends State

#so what im thinking for the block state is so make it so that if the enemy attack lands at the right block
#moment (the first frame where the shine happens) then itll fully block the attack and if it occurs at another
#time during the block animation itll only partially block the damage
#NOTE: a good idea might be to create block cooldown to avoid spam usage 

#bool to store whether the block animation has finsihed yet or not 
var block_done
func enter():
	player.sprite.play("Block")
	self.animation_finished = false
	#waits for the block animation to finish and then can check for other inputs to switch states
	await player.sprite.animation_finished
	self.animation_finished = true
func exit():
	pass

func update(_delta : float) -> void:
	pass

func physics_update(_delta: float) -> void:
	#after the animation is done the player can either move or state will return to idle by default
	if Input.get_vector("move_left","move_right","move_up","move_down") != Vector2.ZERO and self.animation_finished:
		Transitioned.emit(self, "Walk")
	elif self.animation_finished:
		Transitioned.emit(self, "Idle")
		
	#code to impement actual damage blocking will go here
