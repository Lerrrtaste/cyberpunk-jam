extends Area2D

export(float) var effect_length:float = 1.5

func step(delta:float)->void:
	pass

func _ready()->void:
	$Cooldown.connect("timeout",self,"_on_timeout")

func _on_timeout()->void:
	print("froze")
	var affecting = get_overlapping_areas()
	for t in affecting.size():
		if(is_instance_valid(affecting[t])):
			if(!affecting[t].get_node("../").freeze(true)):
				affecting.remove(t)
	yield(get_tree().create_timer(effect_length), "timeout")
	for t in affecting:
		t.get_node("../").freeze(false)
	$Cooldown.start()
	print("defroze")