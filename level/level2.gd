extends "res://level/level_base.gd"

const tower_pos_count = 72
const path_pos_count = 14
var path_pos:Array
var tower_pos:Array
var bag:Array = [0,0,3] # inital towers

func _ready() -> void:
	for i in tower_pos_count:
		if(i != 9 ||i != 19 ||i != 35 ||i != 58):
			tower_pos.append(get_node("Pos/TowerPos%s"%i))
	randomize()
	tower_pos.shuffle()
	$AudioStreamPlayer.stream = preload("res://Assets/sfx/tower_spawn.wav")
	
	for i in path_pos_count:
		path_pos.append(get_node("PosPath/PosPath%s"%i))
	tower_pos.shuffle()
	
	###start tower
	var inst
	inst = factory.new_tower(0)
	$Pos/TowerPos9.add_child(inst)
	
	inst = factory.new_tower(0)
	$Pos/TowerPos35.add_child(inst)
	
	inst = factory.new_tower(0)
	$Pos/TowerPos19.add_child(inst)
	
	inst = factory.new_tower(0)
	$Pos/TowerPos58.add_child(inst)

	
	$Planning.setup(avail_troops,{0:3}) # second param is overwritten

func _unhandled_key_input(event: InputEventKey) -> void:
	if(event.scancode == KEY_ESCAPE && event.pressed):
		get_tree().change_scene("res://test.tscn")
	

func spawn_tower()->bool:
	$AudioStreamPlayer.play()
	var ntype = get_next_type()
	var inst = factory.new_tower(ntype)
	var instp
	if(ntype == 4): # tower on path check
		instp = path_pos.pop_front()
	else:
		instp = tower_pos.pop_front()
	if(is_instance_valid(inst)):
		if(is_instance_valid(instp)):
			instp.add_child(inst)
			return true
		else:
			inst.queue_free()
	return false

func _process(delta:float) -> void:
	$Info/Money.text = "%s$"%$Planning.money

#random bag algr
func get_next_type() -> int:
	randomize()
	#empty bag check
	if(bag.size() == 0):
		bag = [0,0,0,0,1,1,3,3,4]#range(2) # WHAT TOWER IDs AVAILABLE | TODO exclude 4 if no pos path avail anymore
		bag.shuffle()
	#get front element
	return bag.pop_front() #REMOVED FOR DBG ONLY
	#return 3