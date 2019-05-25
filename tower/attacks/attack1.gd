extends Area2D

# Ability for tower id 1
# weakens enemys in range
# range set manually in collison shape 2d node
# effect strength set in set_ab1(...) in troop gd

export(int) var rrange := 24

func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
	connect("area_exited",self,"_on_area_exited")
	#get_node("../").area_range = rrange

func _on_area_entered(area:Area2D)->void:
	area.get_node("../").bAb1 = true
	print("happened 1")

func step(delta:float)->void:
	pass

func _on_area_exited(area:Area2D)->void:
	area.get_node("../").bAb1 = false