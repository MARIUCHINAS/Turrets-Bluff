extends CharacterBody2D

var GameInProgress = false

var RealName = "Player"

var shootCooldown = 0.0
var shootDelay = 0.3

func _ready():
	pass
	
func _enter_tree():
	$ShootTimer.start()
	

func _process(delta):
	if GameInProgress:
		
		shootCooldown = max(0, shootCooldown - delta)
		
		look_at(get_global_mouse_position())


func _on_shoot_timer_timeout():
	$AnimatedSprite2D.animation = "default"


func _on_hud_game_started():
	GameInProgress = true
