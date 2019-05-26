extends Node

# Ability for troop id 5 worm
# replicating every x sec

var factory_scn = load("res://factory.gd")
var factory

func _ready()->void:
	randomize()
	factory = factory_scn.new()
	$Timer.connect("timeout",self,"_on_timeout")

func _on_timeout()->void:
	var inst = factory.new_troop(6)
	inst.global_position = get_node("../").global_position
	inst.path = get_node("../").path
	inst.get_node("Sprite").rotation = get_node("../Sprite").rotation
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("../").get_node("../").add_child(inst)
	

func step(delta:float)->void:
	pass