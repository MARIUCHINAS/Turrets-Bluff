extends CharacterBody2D

@export var speed = 50
@export var acceleration = 0.5

var RealName = "Zombie"

func _physics_process(delta):
	
	look_at(Vector2(288,288))
	
	speed += acceleration
	var velocity = Vector2(speed, 0).rotated((global_rotation))
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.get_collider().RealName == "Bullet":
			queue_free()

func _ready():
	pass
	
func _enter_tree():
	$AnimatedSprite2D.play("default")
