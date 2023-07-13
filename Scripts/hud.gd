extends CanvasLayer

signal game_started

var health = 5.000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hide_stuff():
	for i in get_children():
		i.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_button_up():
	hide_stuff()
	emit_signal("game_started")
	
