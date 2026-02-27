extends State
class_name SlimeIdleState

@export var seek_radius := 30

func enter() -> void:
	entity.sprite.play("Idle")

func exit() -> void:
	pass

func update(_delta : float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass


func _on_slime_pursue_radius_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
