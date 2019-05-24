extends Node

var factory_scn = preload("res://factory.gd")
onready var btn_level1 = $Control/Level1


func _ready()->void:
#	var factory = factory_scn.new()
#	var inst = factory.new_tower(0)
#	if(is_instance_valid(inst)):
#		add_child(inst)
#	else:
#		print("instance invalid!")
	btn_level1.connect("pressed",self,"_btn_lvl1")

func _btn_lvl1()->void:
	get_tree().change_scene("res://level/level1.tscn")