class_name SineWave
extends FundamentalWave


func get_buffer(sample_count: int, sample_hz: float, phase: float) -> PackedFloat32Array:
	var increment = frequency / sample_hz  # * len(wave_data)

	var buffer = PackedFloat32Array()
	buffer.resize(sample_count)
	for i in range(sample_count):
		buffer[i] = sin((TAU * (phase + i)) * increment) * amplitude

	return buffer
