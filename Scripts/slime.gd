extends CharacterBody2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var pursueRadius: Area2D = $SlimePursueRadius
@onready var wander_wait_timer: Timer = $WanderWaitTimer
@onready var wander_raycast: RayCast2D = $WanderRaycast
@onready var sprite: AnimatedSprite2D = $Facing/AnimatedSprite2D
#added facing node2d in order to store all the nodes that i want to flip depending on where the enemy is facing
@onready var facing: Node2D = $Facing


var wander_target_global: Vector2 = Vector2.ZERO
var wander_dir : Vector2 = Vector2.ZERO
var initial_global_pos = null

@export var enemy_speed = 100
