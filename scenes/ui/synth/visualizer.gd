class_name Visualizer
extends SubViewportContainer

var wave: WaveForm

var phase: float = 0

var increments = Vector2i(10, 8)


func _process(delta: float):
	phase += delta * 10
	queue_redraw()


func vertical_adjust(value: float) -> float:
	return size.y * (value * 0.125 + 0.5)


func _draw():
	for i in range(increments.x):
		var increment = i / float(increments.x)
		var thickness = 1
		if i == increments.x * 0.5:
			thickness = 3
		draw_line(
			Vector2(size.x * increment, 0),
			Vector2(size.x * increment, size.y),
			Color.DARK_GREEN,
			thickness
		)

	for i in range(increments.x * 5):
		var increment = i / float(increments.x * 5)
		var mid = size.y * 0.5
		draw_line(
			Vector2(size.x * increment, mid - 5),
			Vector2(size.x * increment, mid + 5),
			Color.DARK_GREEN
		)

	for i in range(increments.y):
		var increment = i / float(increments.y)
		var thickness = 1
		if i == increments.y * 0.5:
			thickness = 3
		draw_line(
			Vector2(0, size.y * increment),
			Vector2(size.x, size.y * increment),
			Color.DARK_GREEN,
			thickness
		)

	for i in range(increments.y * 5):
		var increment = i / float(increments.y * 5)
		var mid = size.x * 0.5
		draw_line(
			Vector2(mid - 5, size.y * increment),
			Vector2(mid + 5, size.y * increment),
			Color.DARK_GREEN
		)

	if !wave:
		return
	var accumulated_frames = wave.get_buffer(int(size.x), 2 ** 16, phase)

	for i in range(len(accumulated_frames) - 1):
		draw_line(
			Vector2(i, vertical_adjust(accumulated_frames[i])),
			Vector2(i + 1, vertical_adjust(accumulated_frames[i + 1])),
			Color.GREEN,
			2,
		)
