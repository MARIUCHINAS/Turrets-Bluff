extends CharacterBody2D

@export var speed = 300
@export var acceleration = 1

var RealName = "Bullet"
	
func _physics_process(delta):
	speed += acceleration
	var velocity = Vector2(speed, 0).rotated((global_rotation))
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.get_collider().RealName == "Zombie":
			
			$AnimatedSprite2D.hide()
			await get_tree().create_timer(0.1).timeout
			queue_free()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_timer_timeout():
	queue_free()
