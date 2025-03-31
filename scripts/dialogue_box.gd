extends MarginContainer

@onready var text_label = $LabelMargin/text_label
@onready var latter_timer_display = $latter_timer_display

const  MAX_WIDYH = 256

var text = ""
var latter_index = 0

var latter_display_timer := 0.07
var space_display_timer := 0.05
var punctuaction_display_timer := 0.02

signal text_display_finished()

func display_text(text_to_display: String):
	text = text_to_display
	text_label.text = text_to_display
	
	await resized
	
	custom_minimum_size.x = min(size.x, MAX_WIDYH)
	
	if size.x > MAX_WIDYH:
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x /2
	global_position.y -= size.y + 24
	text_label.text + ""
	display_latter()
	
func display_latter():
		text_label.text += text[latter_index]
		latter_index += 1
		
		if latter_index >= text.lenght():
			text_display_finished.emit()
			return
			
		match text[latter_index]:
			"!", "?", ",", ".":
				latter_timer_display.start(punctuaction_display_timer)
			"":
				latter_timer_display.start(space_display_timer)
			_:
				latter_timer_display.start(latter_display_timer)

func _on_latter_timer_display_timeout() -> void:
	display_latter()
