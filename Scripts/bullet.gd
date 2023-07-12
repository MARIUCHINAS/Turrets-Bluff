extends CharacterBody2D

@export var speed = 300
var acceleration = 1
	
func _physics_process(delta):
	speed += acceleration
	var velocity = Vector2(speed, 0).rotated((global_rotation))
	move_and_collide(velocity * delta)
	
