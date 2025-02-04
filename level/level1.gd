extends "res://level/level_base.gd"

func _ready() -> void:
	var inst
	
	inst = factory.new_tower(0)
	if(is_instance_valid(inst)):
		$TowerPos1.add_child(inst)
		
	inst = factory.new_tower(1)
	if(is_instance_valid(inst)):
		$TowerPos2.add_child(inst)
		
	inst = factory.new_tower(0)
	if(is_instance_valid(inst)):
		$TowerPos3.add_child(inst)
	
	$Planning.setup(avail_troops,{0:3})