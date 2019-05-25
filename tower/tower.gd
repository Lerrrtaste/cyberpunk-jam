extends Node2D

var area_range
var area_body
var collision_shape
var body
var barrel
var attack = null
var target = null

func set_noderef()->void:
	area_range = $AreaRange
	area_body = $AreaBody
	collision_shape = $Area2D/CollisionShape2D
	body = $Body
	barrel = $Barrel

func _ready() -> void:
	$AreaRange.connect("area_exited",self,"update_target")#"_on_area_exited")
	$AreaRange.connect("area_entered",self,"update_target")

#func _on_area_exited(area:Area2D)->void:
#	target = null
#	yield(get_tree().create_timer(0.1), "timeout")
#	update_target(null)

func update_target(area:Area2D)->void:
	yield(get_tree().create_timer(0.01), "timeout") # prevent get_overlapping_areas() not being up to date
	target = null
	var in_reach = $AreaRange.get_overlapping_areas()
	if(in_reach.size() == 0):
		return
	var closest
	for i in in_reach:
		if(!is_instance_valid(closest)):
			closest = i.get_node("../")
		elif(closest.order_pos>i.get_node("../").order_pos):
			closest = i.get_node("../")
	target = closest
	print(self," updated target to ", target)

func _process(delta: float) -> void:
#	if(!is_instance_valid(target)):
#		update_target()
	if(is_instance_valid(attack)):
		attack.step(delta)
	var target_type = typeof(target)
	if(target_type != TYPE_NIL && is_instance_valid(barrel) && is_instance_valid(target)):
		barrel.rotation = global_position.angle_to_point(target.global_position) - PI/2