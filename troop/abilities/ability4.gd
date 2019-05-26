extends Timer

# ability for id 8 keylogger
# generates x$/s or 2*x$/s if next to other keylogger

export(int) var mps:int = 3

func _ready() -> void:
	connect("timeout",self,"_on_timeout")

func _on_timeout()->void:
	get_node("../").get_node("../Planning").money += mps # TODO double if next to other keylogger

func step(delta:float)->void:
	pass