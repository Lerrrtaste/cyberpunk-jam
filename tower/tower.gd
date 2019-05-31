extends Node2D

var area_range
var area_body
var body
var barrel
var attack = null
var target = null

#ability 1
var bFrozen := false
var freeze_last := 0
const freeze_cooldown := 2 * 1000

##ability 3
#var bOverriden := false

func set_noderef()->void:
	area_range = $AreaRange
	area_body = $AreaBody
	body = $Body
	barrel = $Barrel

func _ready() -> void:
	$AreaRange.connect("area_exited",self,"update_target")#"_on_area_exited")
	$AreaRange.connect("area_entered",self,"update_target")
	$Unfreeze.connect("timeout",self,"_on_unfreeze")

#func _on_area_exited(area:Area2D)->void:
#	target = null
#	yield(get_tree().create_timer(0.1), "timeout")
#	update_target(null)

func update_target(area:Area2D)->void:
#	if(bOverriden):
#		return
	yield(get_tree().create_timer(0.01), "timeout") # prevent get_overlapping_areas() not being up to date
	target = null
	var in_reach = $AreaRange.get_overlapping_areas()
	if(in_reach.size() == 0):
		return
	var closest
	var bClosePrio := false
	for i in in_reach:
		if(i.get_node("../").bHighPrio):
			bClosePrio = true
		if(!is_instance_valid(closest)):
			closest = i.get_node("../")
		elif(closest.order_pos>i.get_node("../").order_pos || (i.get_node("../").bHighPrio && bClosePrio)): # != == xor
			closest = i.get_node("../")
	target = closest
	#print(self," updated target to ", target)

#func target_override(troop:Node2D)->void:
#	bOverriden = true
#	target = troop

func _process(delta: float) -> void:
#	if(bOverriden && global_position.distance_to(target.global_position) > target):
#		update_target()
	if(is_instance_valid(attack) && !bFrozen):
		attack.step(delta)
	var target_type = typeof(target)
	if(target_type != TYPE_NIL && is_instance_valid(barrel) && is_instance_valid(target) && !bFrozen):
		barrel.rotation = global_position.angle_to_point(target.global_position) - PI/2
	update()

func _draw() -> void:
	if(bFrozen):
		draw_circle(Vector2(),40,ColorN("blue"))

#ability 1
func freeze(val:bool,duration:float=1.0)->bool:
	if(bFrozen == val || (val && OS.get_ticks_msec() - freeze_last < freeze_cooldown)): #frozen by other tower
		return false
	bFrozen = val
	if(val):
		freeze_last = OS.get_ticks_msec() if val else freeze_last
	$Unfreeze.start(duration)
	return true

func _on_unfreeze()->void:
	freeze(false)