extends Node2D

var text := "not set"
var font = preload("res://ui/dynfont_popup.tres")

var target_pos := Vector2(-5+randi()%11,-30+randi()%11)
const speed := 20
var color := ColorN("red")

func _ready() -> void:
	update()
#	global_position =get_node("../").get_node("../").global_position
	target_pos += global_position
	$Timer.connect("timeout",self,"_on_timeout")

func _draw() -> void:
	draw_string(font, Vector2(), text, color)

func _process(delta: float) -> void:
	global_position += (target_pos - global_position)/speed

func _on_timeout()->void:
	visible = false
	queue_free()