extends CanvasLayer

signal game_started

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.hide()

func hide_stuff():
	$BackGroundColorRect.hide()
	$StartButton.hide()
	$GameNameLabel.hide()
	
func show_stuff():
	$HealthBar.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	pass


func _on_start_button_button_up():
	hide_stuff()
	show_stuff()
	emit_signal("game_started")
	
