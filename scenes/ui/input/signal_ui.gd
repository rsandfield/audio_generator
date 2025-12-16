@tool
class_name SignalUI
extends HBoxContainer

signal signal_on(key: String, wave: FundamentalWave)
signal signal_off(key: String)

@export var wave: FundamentalWave = SineWave.new()

@export var active = false:
    set(value):
        active = value
        if check_button:
            check_button.button_pressed = value
        if Engine.is_editor_hint():
            return
        if active:
            signal_on.emit(wave.resource_scene_unique_id, wave)
        else:
            signal_off.emit(wave.resource_scene_unique_id)

var wave_types = [
    SineWave,
    SquareWave,
    TriangleWave,
    SawtoothWave,
]

@onready var check_button = $CheckButton


func _on_check_button_toggled(toggled_on: bool):
    active = toggled_on


func _on_frequency_value_changed(new_value: float):
    wave.frequency = abs(new_value)
    $Frequency/LineEdit.text = "%.2f" % wave.frequency


func _on_amplitude_value_changed(new_value: float):
    wave.amplitude = abs(new_value)
    $Amplitude/LineEdit.text = "%.2f" % wave.amplitude

func _on_wave_shape_changed(index: int):
    var new_wave = wave_types[index].new()
    new_wave.frequency = wave.frequency
    new_wave.amplitude = wave.amplitude
    if active:
        signal_off.emit(wave.resource_scene_unique_id)
        signal_on.emit(new_wave.resource_scene_unique_id, new_wave)
    wave = new_wave
