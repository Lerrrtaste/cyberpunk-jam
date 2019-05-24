extends Node

var factory_scn = preload("res://factory.gd")

func _ready()->void:
	var factory = factory_scn.new()
	var inst = factory.new_tower(0)
	if(is_instance_valid(inst)):
		add_child(inst)
	else:
		print("instance invalid!")