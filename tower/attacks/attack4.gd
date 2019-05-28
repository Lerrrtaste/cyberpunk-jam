extends Area2D

#access control attack
#blocking path

export(float) var cooldown := 5.0
export(float) var time_blocking := 3.0
#var bBlocking := false

func step(delta:float)->void:
	pass

func _ready() -> void:
	$Sprite.visible = false
	$Timer.connect("timeout",self,"_on_timeout")
	get_node("../").get_node("AudioStreamPlayer").stream = preload("res://Assets/sfx/tower_accesscontrol_active.wav")

func _on_timeout()->void:
	$CollisionShape2D.disabled = false
	$Sprite.visible = true
	get_node("../").get_node("AudioStreamPlayer").play()
	yield(get_tree().create_timer(time_blocking), "timeout")
	$CollisionShape2D.disabled = true
	get_node("../").get_node("AudioStreamPlayer").stop()
	$Sprite.visible = false
	$Timer.start(cooldown)