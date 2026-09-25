extends AudioStreamPlayer
const BACKGROUND_MUSIC_MAIN = preload("res://assets/sfx/MainMusic.mp3")
const BACKGROUND_MUSIC_STORE = preload("res://assets/sfx/StoreMusic.mp3")

@onready var sound_pool_size = 8
@onready var store_player = $AudioStreamPlayerStore
var audio_players = []
var player_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Generates the array of audio players to allow overlapping sounds
	for i in range(sound_pool_size):
		var audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		audio_players.append(audio_player)
	stream = BACKGROUND_MUSIC_MAIN
	store_player.stream = BACKGROUND_MUSIC_STORE
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Loop the audio
	if !playing:
		play()
	if !store_player.playing:
		store_player.play()
		
	# Play the correct soundtrack:
	if globals.scene != "store":
		if store_player.volume_db > -80:
			store_player.volume_db -= 1
		if volume_db < 0:
			volume_db += 1
	else:
		if store_player.volume_db < 0:
			store_player.volume_db += 1
		if volume_db > -80:
			volume_db -= 1
func play_sound(audio_stream: AudioStream) -> void:
	var player = audio_players[player_index]
	player.stream = audio_stream
	player.play()
	player_index = (player_index + 1) % sound_pool_size
