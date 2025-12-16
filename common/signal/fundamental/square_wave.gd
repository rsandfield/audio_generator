class_name SquareWave
extends FundamentalWave


func get_buffer(sample_count: int, sample_hz: float, phase: float) -> PackedFloat32Array:
	var buffer = PackedFloat32Array()
	buffer.resize(sample_count)
	for i in range(sample_count):
		for j in range(7):
			var m = 1 + 2 * j
			buffer[i] += series_function(sample_hz, phase + i, frequency * m, amplitude / m)

	return buffer


func series_function(sample_hz: float, phase: float, f: float, a: float) -> float:
	var increment = f / sample_hz  # * len(wave_data)
	return sin(phase * increment * TAU) * a
