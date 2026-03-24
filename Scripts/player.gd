extends CharacterBody2D


@onready var collision: CollisionShape2D = $CollisionShape2D

@onready var sword_hit_box: Area2D = $Facing/SwordHitBox
@onready var sprite: AnimatedSprite2D = $Facing/AnimatedSprite2D
@onready var facing: Node2D = $Facing
@export var player_health = 5

@export var speed : float
@export var baseFriction : float
