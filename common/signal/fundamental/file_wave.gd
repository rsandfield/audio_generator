class_name FileWave
extends FundamentalWave

@export var filename: String = "sine"

var file_pattern = "res://common/signal/fundamental/%s.res"
var wave_data: PackedFloat32Array


func read_wave_file():
	var file: FileAccess = FileAccess.open(file_pattern % filename, FileAccess.READ)
	if file:
		var offset = 0
		var byte_data = file.get_buffer(file.get_length())
		file.close()
		while offset < byte_data.size():
			# Decode a 32-bit float from the current offset
			var float_value = byte_data.decode_float(offset)
			wave_data.append(float_value)
			offset += 4  # Move to the next float (4 bytes per float32)
	else:
		print("Error creating or opening file: ", FileAccess.get_open_error())


func get_buffer(sample_count: int, sample_hz: float, phase: float) -> PackedFloat32Array:
	if !wave_data:
		read_wave_file()

	var increment = frequency / sample_hz * len(wave_data)

	var buffer = PackedFloat32Array()
	buffer.resize(sample_count)
	for i in range(sample_count):
		var index = fmod(float(phase + i) * increment, len(wave_data))
		buffer[i] = wave_data[index] * amplitude

	return buffer


func write_file(wave: WaveForm):
	var data = wave.get_buffer(88200, frequency, 0)
	var file: FileAccess = FileAccess.open(file_pattern % filename, FileAccess.WRITE)
	if file:
		file.store_buffer(data.to_byte_array())
		file.close()
		print("File created and sata written successfully")
	else:
		print("Error creating or opening file: ", FileAccess.get_open_error())
