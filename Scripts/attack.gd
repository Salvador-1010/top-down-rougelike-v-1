extends State
class_name playerattack

@export var damage: float
@export var player: CharacterBody2D
@export var playerAnimator: AnimatedSprite2D
@export var attack_cooldown : float

var attack_cooldown_saver: float
func enter() -> void:
	attack_cooldown_saver = attack_cooldown
	playerAnimator.play("Attack")
	
func exit() -> void:
	attack_cooldown = attack_cooldown_saver
	
func update(_delta : float) -> void:
	print(attack_cooldown)
	#will countdown the attack cooldown until i am able to attack again
	if attack_cooldown > 0:
		attack_cooldown -= _delta
	if attack_cooldown <= 0:
		Transitioned.emit(self, "Idle")
	
func physics_update(_delta: float) -> void:
	pass
	
