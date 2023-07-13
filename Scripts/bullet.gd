extends CharacterBody2D

@export var speed = 300
@export var acceleration = 1
	
func _physics_process(delta):
	speed += acceleration
	var velocity = Vector2(speed, 0).rotated((global_rotation))
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.get_collider().name == "Zombie":
			$AnimatedSprite2D.hide()
			await get_tree().create_timer(0.05).timeout
			queue_free()
	
