class_name SawtoothWave
extends FundamentalWave


func filepath() -> String:
	return "res://common/signal/sawtooth.res"


func get_buffer(sample_count: int, sample_hz: float, phase: float) -> PackedFloat32Array:
	var buffer = PackedFloat32Array()
	buffer.resize(sample_count)
	for i in range(sample_count):
		for j in range(20):
			buffer[i] += series_function(sample_hz, phase + i, j + 1)
		buffer[i] *= 2 * amplitude / PI

	return buffer


func series_function(sample_hz: float, phase: float, k: float) -> float:
	var increment = frequency / sample_hz
	var s = -1 ** k
	var n = sin(TAU * k * increment * phase)
	return s * n / k
