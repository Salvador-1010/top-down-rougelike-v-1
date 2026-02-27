extends State
class_name PursueState

func enter() -> void:
	entity.sprite.play("Move")

func exit() -> void:
	pass

func update(_delta : float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
