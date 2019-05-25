extends Node

# ABIITY FOR TROOP ID 1: PACKET SNIFFER
# Buffs player units (3 units ahead/behind) + x% HP 

export(float) var buff = 0.10
export(int) var buff_reach = 3

var buffing:Array
#var dbglines:Array 

func _ready() -> void:
	pass
#	for i in buff_reach*2:
#		var inst = Line2D.new()
#		add_child(inst)
#		dbglines.append(inst)
#		inst.default_color = ColorN("green")

func step(delta:float)->void:
	if(buffing.size() != buff_reach*2):
		#search new units to buff
		for t in get_node("../").get_node("../").get_nearby_troops(get_node("../").order_pos,buff_reach):
			if !buffing.has(t):
				buffing.append(t)
				t.connect("died",self,"_on_troop_death")
				t.hp = t.hp * (1.0+buff)
				t.hp_max = t.hp_max * (1.0+buff)