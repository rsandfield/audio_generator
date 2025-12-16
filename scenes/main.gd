extends Node2D

var wave: CompoundWave = CompoundWave.new()

@onready var audio = $Audio
@onready var visual = $CanvasLayer/PanelContainer/MarginContainer/Columns/Display/Visualizer

func _ready():
    audio.wave = wave
    visual.wave = wave

func _on_signal_on(key: String, value: WaveForm):
    wave.components[key] = value

func _on_signal_off(key: String):
    wave.components.erase(key)
