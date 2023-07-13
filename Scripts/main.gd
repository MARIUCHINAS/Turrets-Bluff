extends Node

var GameInProgress = false
@export var BulletScene: PackedScene

func _ready():
	pass
	
func _process(delta):
	if GameInProgress:
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


func _on_hud_game_started():
	GameInProgress = true


func _on_pad_area_entered(area):
	print(area.name)
	print("pront")


func _on_pad_body_entered(body):
	if body.RealName == "Zombie":
		body.queue_free()
		$HUD.health -= 20
		print("Heath ", $HUD/HealthBar.value)
