extends CanvasLayer

signal game_started

var health = 100

var firstTime = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.hide()
	$StartedAudioStreamPlayer.play()

func hide_stuff():
	$BackGroundColorRect.hide()
	$StartButton.hide()
	$GameNameLabel.hide()
	
func show_stuff():
	$HealthBar.show()
	
func show_again():
	$HealthBar.hide()
	
	$BackGroundColorRect.show()
	$StartButton.show()
	$GameNameLabel.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !firstTime:
		$GameNameLabel.text = "You died"
		$StartButton.text = "Try Again?"
	
func _physics_process(delta):
	pass


func _on_start_button_button_up():
	firstTime = false
	hide_stuff()
	show_stuff()
	emit_signal("game_started")
	
