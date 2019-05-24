extends Control

onready var troop_order:PoolIntArray
var troops_available:Dictionary
var towers:Dictionary
var slot_scn:PackedScene = preload("res://ui/planning_unitSlot.tscn")
var slots:Array
onready var container_slots = $Units

func setup(avail_troops:Dictionary,towers:Dictionary)->void:
	troops_available = avail_troops
	
	#create and setup troop planning_unitSlot scenes
	for t in troops_available.keys():
		var inst = slot_scn.instance()
		add_child(inst)#container_slots.add_child(inst)
		inst.setup(t,troops_available.get(t))
#		slots.resize(slots.size()+1)
		slots.append(inst)
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_bottom = 130+200
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_right = (slots.size())*(64-8)+8
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_left = (slots.size()-1)*(64+8)
#		yield(get_tree().create_timer(0.3), "timeout")
		inst.margin_top = 200
		inst.rect_size = Vector2(64,130)