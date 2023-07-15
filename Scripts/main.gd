extends Node

var GameInProgress = false

@export var BulletScene: PackedScene
@export var ZombieScene: PackedScene

var hardness_mult = 1.0

func _ready():
	pass
	
	
func _process(delta):
	if GameInProgress:
		
		if $HUD.health <= 0:
			restart_game()
		
		if Input.is_action_just_pressed("shoot"):
			#var mouse_position = get_viewport().get_mouse_position()
			#var ScareZoneSpawnLocation = mouse_position
			#var ScareZone = ScareZoneScene.instantiate()
			#get_tree().get_root().add_child(ScareZone)
			#ScareZone.position = ScareZoneSpawnLocation
		
			var BulletSpawnLocation = $Player.position
			var Bullet = BulletScene.instantiate()
			get_tree().get_root().add_child(Bullet)
			Bullet.position = BulletSpawnLocation
			Bullet.look_at(get_viewport().get_mouse_position())


func restart_game():
	GameInProgress = false
	$Player.GameInProgress = false
	hardness_mult = 1.0
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

func _on_pad_area_entered(area):
	print(area.name)
	print("pront")


func _on_pad_body_entered(body):
	if body.RealName == "Zombie":
		if body:
			body.queue_free()
		$HUD.health -= 20
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
	hardness_mult += 0.5
	$HealTimer.wait_time = hardness_mult
