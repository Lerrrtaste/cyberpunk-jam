extends Area2D

var effect_length:float = 2.0

func step(delta:float)->void:
	pass

func _ready()->void:
	$Cooldown.connect("timeout",self,"_on_timeout")

func _on_timeout()->void:
	var reaching = get_overlapping_areas()
	var freezing:Array
	get_node("../").sprite.animation = "active"
	for t in reaching:
		if(t.get_node("../").freeze(true,effect_length)):
			freezing.append(t)
	yield(get_tree().create_timer(effect_length), "timeout")
	if(get_node("../").sprite.animation == "active"):
		get_node("../").sprite.animation = "default"
#	for t in freezing:
#		t.get_node("../").freeze(false)
	$Cooldown.start(3 + randi()%3)