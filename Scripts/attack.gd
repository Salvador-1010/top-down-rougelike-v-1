extends State
class_name playerattack

@export var damage: float
@export var player: CharacterBody2D
@export var playerAnimator: AnimatedSprite2D
@export var attack_cooldown : float
@export var combo_window: float

var combo_queued := false
var elapsed := 0.0
var attack_cooldown_saver: float

var goingcombo = false
func enter() -> void:
	elapsed = 0.0
	combo_queued = true
	player.velocity = Vector2.ZERO
	attack_cooldown_saver = attack_cooldown
	playerAnimator.play("Attack")
	playerAnimator.animation_finished.connect(transition)
	
func exit() -> void:
	#disconnects the animation signal to avoid any erros
	if playerAnimator.animation_finished.is_connected(transition):
		playerAnimator.animation_finished.disconnect(transition)
	attack_cooldown = attack_cooldown_saver
	
func update(_delta : float) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	await playerAnimator.animation_finished
	if playerAnimator.animation == "Attack":
		playerAnimator.play("Attack2")

func transition() -> void:
	#checks to make sure that the finished animation was the attck so we can go back to idle
	if playerAnimator.animation == "Attack" and !combo_queued:
		Transitioned.emit(self, "Idle")
