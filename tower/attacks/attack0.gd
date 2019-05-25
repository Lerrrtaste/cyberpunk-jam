extends Node

# Attack for tower id 0
# simple shooting tower

onready var area_range = get_node("../AreaRange")
onready var timer = $Cooldown
var projectile_scn = preload("res://helpers/projectile.tscn")

export(int) var rrange := 128+64-32

func _ready() -> void:
	get_node("../AreaRange/CollisionShape2D").shape.radius = rrange
	timer.connect("timeout",self,"_on_timeout")

func _on_timeout()->void:
	if(is_instance_valid(get_node("../").target)):
		var inst = projectile_scn.instance()
		add_child(inst)
		inst.target = get_node("../").target
		inst.global_position = get_node("../").global_position
		inst.set_process(true)

func step(delta:float)->void:
	pass