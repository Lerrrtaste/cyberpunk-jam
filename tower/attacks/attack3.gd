extends Area2D

#attack for tower id 3 anti virus
# does simpel area damage

export(int) var dmg := 20

func step(delta:float)->void:
	pass

func _ready() -> void:
	$Sprite.visible = false
	$Cooldown.connect("timeout",self,"_on_timeout")
	get_node("../").get_node("AudioStreamPlayer").stream = preload("res://Assets/sfx/tower_antivirus_firing.wav")

func _on_timeout()->void:
	if(get_node("../").bFrozen):
		return
	$Sprite.visible = true
	for i in get_overlapping_areas():
		if(is_instance_valid(i)):
			i.get_node("../").take_damage(dmg)
			get_node("../").get_node("AudioStreamPlayer").play()
	$Cooldown.start(1 + randi()%3) # change cooldown here
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.visible = false