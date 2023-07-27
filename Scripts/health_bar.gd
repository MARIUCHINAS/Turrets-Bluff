extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value=get_parent().health
	
func emmit_damage():
	$GPUParticles2D.emitting = true
	await get_tree().create_timer(0.4).timeout
	$GPUParticles2D.emitting = false
