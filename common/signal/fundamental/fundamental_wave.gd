@abstract
class_name FundamentalWave
extends WaveForm
@export var frequency: float = 440
@export var amplitude: float = 1

@abstract
func get_buffer(sample_count: int, sample_hz: float, phase: float) -> PackedFloat32Array
