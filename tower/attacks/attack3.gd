extends Area2D

#attack for tower id 3 anti virus
# does simpel area damage

export(int) var dmg := 20

func step(delta:float)->void:
	pass

func _ready() -> void:
	$Cooldown.connect("timeout",self,"_on_timeout")

func _on_timeout()->void:
	for i in get_overlapping_areas():
		if(is_instance_valid(i)):
			i.get_node("../").take_damage(dmg)
	$Cooldown.start(1 + randi()%3) # change cooldown here