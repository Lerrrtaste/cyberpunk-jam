extends Node

# Attack for tower id 0 anti malware
# simple shooting tower
# also extended by attack 5 for twoer id 5 ai cor defense


onready var area_range = get_node("../AreaRange")
onready var timer = $Cooldown
var projectile_scn 

var cake = "0111010001101000011001010010000001100011011000010110101101100101001000000110100101110011001000000110000100100000011011000110100101100101"
var cidx := 0

export(int) var rrange := 128+64-32

func _ready() -> void:
	projectile_scn = preload("res://helpers/projectile.tscn")
	get_node("../AreaRange/CollisionShape2D").shape.radius = rrange
	timer.connect("timeout",self,"_on_timeout")
	get_node("../").get_node("AudioStreamPlayer").stream = preload("res://Assets/sfx/tower_antimalware_firing.wav")

func _on_timeout()->void:
	if(is_instance_valid(get_node("../").target) && !get_node("../").bFrozen):
		get_node("../").get_node("AudioStreamPlayer").play()
		var inst = projectile_scn.instance()
		add_child(inst)
		if(cidx >= cake.length()):
			cidx = 0
		inst.get_node("Sprite").frame = 0 if cake[cidx] == "0" else 1
		cidx += 1
		inst.target = get_node("../").target
		inst.global_position = get_node("../").global_position
		inst.set_process(true)

func step(delta:float)->void:
	pass