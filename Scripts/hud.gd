extends CanvasLayer

signal game_started

var health = 100
var wave = 0

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
	$MainMenuAudioStreamPlayer.stop()
	$HealthBar.show()
	$WaveCountLabel.show()
	$WaveCountLabel2.show()
	
func show_again():
	$MainMenuAudioStreamPlayer.play()
	$HealthBar.hide()
	$WaveCountLabel.hide()
	$WaveCountLabel2.hide()
	
	$BackGroundColorRect.show()
	$StartButton.show()
	$GameNameLabel.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !firstTime:
		$GameNameLabel.text = "You died"
		$StartButton.text = "Try Again?"
	
func _physics_process(delta):
	$WaveCountLabel.text = str(wave)


func _on_start_button_button_up():
	firstTime = false
	hide_stuff()
	show_stuff()
	emit_signal("game_started")
	
