extends Area2D

export(float) var effect_length:float = 1.5

func step(delta:float)->void:
	pass

func _ready()->void:
	$Cooldown.connect("timeout",self,"_on_timeout")

func _on_timeout()->void:
	var affecting = get_overlapping_areas()
	var blacklist:Array
	for t in affecting:
		if(!t.get_node("../").freeze(true)):
			pass#blacklist.append(t) #TODO need a way to only unfreeze towers, frozen by self
	yield(get_tree().create_timer(effect_length), "timeout")
	for t in affecting:
		t.get_node("../").freeze(false)
	$Cooldown.start()