extends AnimatedSprite

func _ready() -> void:
	connect("animation_finished",self,"dead")

func dead():
	visible = false
	queue_free()