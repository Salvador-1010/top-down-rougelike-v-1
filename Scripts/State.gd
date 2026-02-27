extends Node
class_name State

signal Transitioned

var entity :CharacterBody2D
var animation_finished : bool

func enter() -> void:
	pass

func exit() -> void:
	pass

func Handle_input(_event: InputEvent) -> void:
	pass
	
func update(_delta : float) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
