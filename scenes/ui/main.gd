extends Node2D

@export var wave: WaveForm

@onready var audio = $Audio
@onready var visual = $CanvasLayer/PanelContainer/MarginContainer/Visualizer


func _ready():
	audio.wave = wave
	visual.wave = wave
