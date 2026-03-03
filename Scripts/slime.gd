extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var pursueRadius: Area2D = $SlimePursueRadius
var wander_target_globa: Vector2 = Vector2.ZERO
