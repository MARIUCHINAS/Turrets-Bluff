extends Node

var GameInProgress = false

@export var BulletScene: PackedScene
@export var ZombieScene: PackedScene

@export var shootCooldown = 0.0
@export var shootDelay = 0.3

var hardness_mult = 1.0

func _ready():
	pass

func emmit_player_particles():
	$Player/GPUParticles2D.emitting = true
	await get_tree().create_timer(0.2).timeout
	$Player/GPUParticles2D.emitting = false
	
func _process(delta):
	if GameInProgress:
		
		shootCooldown = max(0, shootCooldown - delta)
		
		if $HUD.health <= 0:
			restart_game()
		
		if Input.is_action_pressed("shoot") and shootCooldown <= 0:
			# Perform the shooting action
			var BulletSpawnLocation = $Player.position
			var Bullet = BulletScene.instantiate()
			get_tree().get_root().add_child(Bullet)
			Bullet.position = BulletSpawnLocation
			Bullet.look_at(get_viewport().get_mouse_position())
			
			$Player/ShootAudioStreamPlayer.play()
			
			$Player/AnimatedSprite2D.animation = "shoot"
			emmit_player_particles()
			# Reset the cooldown
			shootCooldown = shootDelay


func restart_game():
	GameInProgress = false
	$Player.GameInProgress = false
	hardness_mult = 1.0
	$HUD.wave = 0
	$HealTimer.stop()
	$ZombieSpawnTimer.stop()
	$HUD.show_again()
	for i in get_children():
		if i.is_in_group("Zombie") or i.is_in_group("Bullet"):
			i.queue_free()
			
			
func _on_hud_game_started():
	$HUD.health = 100
	hardness_mult = 1.0
	$HealTimer.start()
	$ZombieSpawnTimer.start()
	GameInProgress = true
	

func spawn_zombie():
	$ZombieSpawnPath2D/ZombieSpawnPathFollow2D.progress_ratio = randf()
	var ZombieSpawnLocation = $ZombieSpawnPath2D/ZombieSpawnPathFollow2D.position
	var Zombie = ZombieScene.instantiate()
	get_tree().get_root().add_child(Zombie)
	Zombie.position = ZombieSpawnLocation


func _on_pad_body_entered(body):
	if body.RealName == "Zombie":
		if body:
			body.queue_free()
		$Pad/DamagedAudioStreamPlayer.play()
		$HUD/HealthBar.emmit_damage()
		$HUD.health -= 20
		$Pad/AnimatedSprite2D.play("damage")
		print("Heath ", $HUD/HealthBar.value)

func _on_heal_timer_timeout():
	if $HUD.health <= 0:
		pass
	else:
		if $HUD.health < 100:
			$HUD.health += 5
		elif $HUD.health > 100:
			$HUD.health = 100


func _on_zombie_spawn_timer_timeout():
	for i in hardness_mult:
		spawn_zombie()
	$HUD.wave += 1
	hardness_mult += 0.5
	$HealTimer.wait_time = hardness_mult
