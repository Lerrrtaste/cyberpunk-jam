extends Node

# ABIITY FOR TROOP ID 1: PACKET SNIFFER
# Buffs player units (3 units ahead/behind) + x% HP 

export(float) var buff = 1.0
export(int) var buff_reach = 3

var buffing:Array
#var dbglines:Array 

func _ready() -> void:
	connect("area_entered",self,"_on_body_entered")
	connect("area_exited",self,"_on_body_exited")

func _on_body_entered(area:Area2D)->void:
	if(area == get_node("../").get_node("Area2D")):
		return
	#print("entered")
	var t = area.get_node("../")
	t.hp = int(t.hp * (1.0+buff))
	t.hp_max = int(t.hp_max * (1.0+buff))
	t.bBuffed = true
	
func _on_body_exited(area:Area2D)->void:
	#print("de - entered")
	var t = area.get_node("../")
	t.hp = int(t.hp * (1.0-buff))
	t.hp_max = int(t.hp_max * (1.0-buff))
	t.bBuffed = false

func _unhandled_key_input(event: InputEventKey) -> void:
	if(event.scancode == KEY_H && event.pressed):
		print(buffing)

func _on_troop_death(inst:Node2D)->void:
	for i in buffing.size():
		if(buffing[i] == inst):
			buffing.remove(i)
			return
			

func step(delta:float)->void:
	pass
#	for t in get_node("../").get_node("../").get_nearby_troops(get_node("../").order_pos,buff_reach):
#		if !buffing.has(t) && is_instance_valid(t) &&  get_node("../").order_pos - t.order_pos <= buff_reach:
#			buffing.append(t)
#			t.connect("died",self,"_on_troop_death")
#			t.hp = int(t.hp * (1.0+buff))
#			t.hp_max = int(t.hp_max * (1.0+buff))
#			t.bBuffed = true