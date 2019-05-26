extends "res://tower/attacks/attack0.gd"

# attack for twoer id 5 ai core defense
# extemds attack id 0
# its the basic shooting but uses different projectile

func _ready() -> void:
	._ready()

func _on_timeout()->void:
	if(is_instance_valid(get_node("../").target) && !get_node("../").bFrozen):
		var inst = projectile_scn.instance()
		add_child(inst)
		if(cidx >= cake.length()):
			cidx = 0
		inst.get_node("Sprite").frame = 0 if cake[cidx] == "0" else 1
		cidx += 1
		inst.target = get_node("../").target
		inst.global_position = get_node("../").global_position
		inst.set_process(true)