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
		container_slots.add_child(inst)
		inst.setup(t,troops_available.get(t))