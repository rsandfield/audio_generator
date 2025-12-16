class_name CompoundWave
extends WaveForm

var components: Dictionary[String, WaveForm] = {}

func get_buffer(sample_count: int, sample_hz: float, phase: float) -> PackedFloat32Array:
	var accumulated_frames = PackedFloat32Array()
	accumulated_frames.resize(sample_count)
	for wave in components.values():
		var values = wave.get_buffer(sample_count, sample_hz, phase)
		for i in range(sample_count):
			accumulated_frames[i] += values[i]
	return accumulated_frames
