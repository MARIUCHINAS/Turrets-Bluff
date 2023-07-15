extends CharacterBody2D

var GameInProgress = false

var RealName = "Player"

func _ready():
	pass
	
func _enter_tree():
	$ShootTimer.start()
	

func _physics_process(delta):
	if GameInProgress:
		look_at(get_global_mouse_position())
	
		if Input.is_action_just_pressed("shoot"):
			$ShootAudioStreamPlayer.play()

			$AnimatedSprite2D.animation = "shoot"
			$GPUParticles2D.emitting = true
			await get_tree().create_timer(0.2).timeout
			$GPUParticles2D.emitting = false
	



func _on_shoot_timer_timeout():
	$AnimatedSprite2D.animation = "default"


func _on_hud_game_started():
	GameInProgress = true
