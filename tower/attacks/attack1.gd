extends Area2D

# Ability for tower id 1 
# weakens enemys in range
# range set manually in collison shape 2d node
# effect strength set in set_ab1(...) in troop gd

export(float) var rrange:float = 96.0

var bShrunk := false

func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
	connect("area_exited",self,"_on_area_exited")
	$CollisionShape2D.shape.radius = rrange

func _on_area_entered(area:Area2D)->void:
	area.get_node("../").ab1(true)

func step(delta:float)->void:
	pass
#	if(get_node("../").bFrozen && !bShrunk):
#		$CollisionShape2D.shape.radius = 1.0
#
#	if(!get_node("../").bFrozen && bShrunk):
#		$CollisionShape2D.shape.radius = rrange

func _on_area_exited(area:Area2D)->void:
	area.get_node("../").ab1(false)