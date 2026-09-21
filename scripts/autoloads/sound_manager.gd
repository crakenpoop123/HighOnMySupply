extends Node

@onready var sound_pool_size = 8
var audio_players = []
var player_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Generates the array of audio players to allow overlapping SFX
	for i in range(sound_pool_size):
		var audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		audio_players.append(audio_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_sound(audio_stream: AudioStream) -> void:
	var player = audio_players[player_index]
	player.stream = audio_stream
	player.play()
	player_index = (player_index + 1) % sound_pool_size
