extends LineEdit

signal value_changed(value: float)

var old_text = text


func _ready():
	_on_text_submitted(text)


func _on_text_changed(new_text: String):
	if new_text.is_valid_float():
		old_text = new_text
	else:
		text = old_text


func _on_text_submitted(new_text: String):
	if new_text.is_valid_float():
		old_text = "%.2f" % abs(new_text.to_float())
		text = old_text
		value_changed.emit(text.to_float())
	else:
		text = old_text


func _increment_value(value: float):
	var old_value = old_text.to_float()
	old_value += value
	_on_text_submitted("%.2f" % old_value)
