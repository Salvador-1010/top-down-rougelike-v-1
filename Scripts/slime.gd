extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var pursueRadius: Area2D = $SlimePursueRadius
@onready var wander_raycast: RayCast2D = $WanderRaycast
@onready var wander_wait_timer: Timer = $WanderWaitTimer
