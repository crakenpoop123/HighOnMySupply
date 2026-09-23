extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update noise level in the shader
	if material is ShaderMaterial:
		material.set_shader_parameter("u_noise_level", globals.noise_level)
