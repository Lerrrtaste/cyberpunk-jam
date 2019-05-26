extends Area2D

#ability for id 7 spoof
# copies the abilites of all nearby troops
# 1,2,4,8 are cloneable

var factory_scn = load("res://factory.gd")
var factory

var cloning:Dictionary = { 	1 : false,
							2 : false,
							4 : false,
							8 : false}
func _ready()->void:
	factory = factory_scn.new()

func _physics_process(delta: float) -> void:
	var reaching = get_overlapping_areas()
	for i in reaching:
		if(cloning.has(i.get_node("../").id)): # id clonable check 
			if(!cloning.get(i.get_node("../").id)): # id not already cloned check
				clone_start(i.get_node("../").id)

func clone_start(id:int)->void:
	assert(!cloning[id])
	cloning[id] = true
	match id:
		1:
			var inst = factory.troop_ability[id].instance()
			get_node("../")

func clone_end(id:int)->void:
	pass

func step(delta:float)->void:
	pass