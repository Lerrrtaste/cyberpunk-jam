extends Node2D

var text := "not set"
var font = preload("res://ui/dynfont_popup.tres")

var target_pos := Vector2(0,-20)
const speed := 20

func _ready() -> void:
	update()
#	global_position =get_node("../").get_node("../").global_position
#	target_pos += global_position

func _draw() -> void:
	draw_string(font, position, text, ColorN("green"))

func _process(delta: float) -> void:
	global_position += (target_pos - global_position)/speed
	if(global_position.distance_to(target_pos) < 2.0):
		visible = false
		queue_free()