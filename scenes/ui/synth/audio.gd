class_name AudioGenerator
extends Node

@export var gain: float = 1:
	set(value):
		print("Old: %f New: %f" % [gain, value])
		if value > 1:
			gain = 1
		if gain < 0:
			gain = 0
		gain = value
	get():
		return gain
@export var muted: bool = false

var playback: AudioStreamPlayback
var phase: int = 0
var wave: WaveForm

@onready var player: AudioStreamPlayer = $AudioStreamPlayer
@onready var sample_hz = $AudioStreamPlayer.stream.mix_rate


func _ready():
	player.play()
	playback = player.get_stream_playback()
	if !muted:
		fill_buffer()


func _process(_delta: float):
	if !muted:
		fill_buffer()


func fill_buffer():
	var frames_available = playback.get_frames_available()
	if frames_available == 0:
		return
	var frames = PackedVector2Array()
	frames.resize(frames_available)

	if !wave:
		for i in range(frames_available):
			frames[i] = Vector2.ZERO
	else:
		var accumulated_frames = wave.get_buffer(frames_available, sample_hz, phase)
		for i in range(frames_available):
			frames[i] = (Vector2.ONE * accumulated_frames[i] * gain)
	playback.push_buffer(frames)

	phase += frames_available


func mute(value: bool):
	muted = value


func set_volume(value: float):
	gain = value * 0.01
