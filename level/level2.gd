extends "res://level/level_base.gd"

const tower_pos_count = 54
var tower_pos:Array
var bag:Array

func _ready() -> void:
	for i in tower_pos_count:
		tower_pos.append(get_node("Pos/TowerPos%s"%i))
	randomize()
	tower_pos.shuffle()
	
	$Planning.setup(avail_troops,{0:3})

func _unhandled_key_input(event: InputEventKey) -> void:
	if(event.scancode == KEY_T && event.pressed):
		spawn_tower()

func spawn_tower()->void:
	var inst = factory.new_tower(get_next_type())
	var instp = tower_pos.pop_front()
	if(is_instance_valid(inst)):
		if(is_instance_valid(instp)):
			instp.add_child(inst)
		else:
			inst.queue_free()

func _process(delta:float) -> void:
	$MoneyLabel/Money.text = "%s$"%$Planning.money

#random bag algr
func get_next_type() -> int:
	randomize()
	#empty bag check
	if(bag.size() == 0):
		bag = range(2) # WHAT TOWER IDs AVAILABLE
		bag.shuffle()
	#get front element
	return bag.pop_front()