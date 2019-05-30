extends Timer

# ability for id 8 keylogger
# generates x$/s or 2*x$/s if next to other keylogger

export(int) var mps:int = 2
var popup_scn = preload("res://helpers/popup.tscn")

func _ready() -> void:
	connect("timeout",self,"_on_timeout")

func _on_timeout()->void:
	var mult = randi()%(mps+1)
	get_node("../").sprite.animation = "active"
	get_node("../").get_node("../Planning").money += mps+mult # TODO double if next to other keylogger
	var inst = popup_scn.instance()
	inst.text = "+%s$"%(mps+mult)
	inst.color = ColorN("green")
	get_node("../").add_child(inst)
#	var inst = popup_scn.instance()
#	inst.text = "+%s$"%mps
#	inst.position = get_node("../").position
#	add_child(inst)
	yield(get_tree().create_timer(0.5), "timeout")
	if(get_node("../").sprite.animation == "active"):
		get_node("../").sprite.animation = "default"

func step(delta:float)->void:
	pass