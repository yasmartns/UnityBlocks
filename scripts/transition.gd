extends CanvasLayer

@onready  var color_rect = $color_rect

func _ready() -> void:
	show_new_scene()

func change_scene(path, delay = 2.5) -> void:
	var scene_trasition = get_tree().create_tween()
	scene_trasition.tween_property(color_rect, "thereshold", 1.0, 0.5).set_delay(delay)
	await scene_trasition.finished
	assert(get_tree().change_scene_to_file(path) == OK)

func show_new_scene():
	var show_trasintion = get_tree().create_tween()
	show_trasintion.tween_property(color_rect, "thereshold", 0.0, 0.5).from(1.0)
