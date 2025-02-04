extends Node2D
class_name troop_class

var area2d
var collision_shape
var sprite
#var attack = null
var ability = null
var tower_prio:Dictionary

var dead_clone_scn = preload("res://helpers/dead_clone.tscn")
var popup_scn = preload("res://helpers/popup.tscn")
export(int) var speed:int = 500
var speed_og = speed
var boost_multiplier:float = 1.0 #export(float) var boost_multiplier:float = 1.0 BROKEN DONT CHANGE
var boost:float = 0.0
var hp_max:int
var hp:int
var path = null
var order_pos:int
var dmg_pre := 0
var bFinished := false 

var death_sound

var computer_dmg:int

var bBuffed := false #ability0
var bAb1 := false # attack 1

var bHighPrio:bool

signal died(inst)

func set_noderef()->void:
	area2d = $Area2D
	collision_shape = $Area2D/CollisionShape2D
	sprite = $Sprite
	hp = hp_max

func _ready()->void:
	$Sprite/Probe1.position = Vector2(-6+randi()%5,0)
	$Sprite/Probe1.collide_with_areas = true
	$Sprite/Probe1.collide_with_bodies = false
	$Sprite/Probe2.collide_with_areas = true
	$Sprite/Probe2.collide_with_bodies = false
	$Sprite/Probe3.collide_with_areas = true
	$Sprite/Probe3.collide_with_bodies = false
	
#	$Sprite/Probe1.exclude_parent = false
#	$Sprite/Probe2.exclude_parent = false
#	$Sprite/Probe3.exclude_parent = false
	
#	$Sprite/Probe1.add_exception(get_node("../"))
#	$Sprite/Probe2.add_exception(get_node("../"))
#	$Sprite/Probe3.add_exception(get_node("../"))

func take_damage(dmg:int)->void:
	get_node("../").get_node("LCamera").add_trauma(0.1)
	if(hp-dmg <= 0):
		die()
	hp -= dmg
	update()
	var inst = popup_scn.instance()
	inst.text = "-%s"%dmg
	add_child(inst)
	$Sprite.modulate = ColorN("red")
	yield(get_tree().create_timer(0.025), "timeout")
	$Sprite.modulate = ColorN("white")

#func _unhandled_key_input(event: InputEventKey) -> void:
#	if(event.scancode == KEY_T && event.pressed && order_pos == 2):
#		take_damage(50)

func die()->void:
	get_node("../").get_node("LCamera").set_trauma(1.0)
	get_node("../").register_death(self)
	emit_signal("died",self)
	var inst = dead_clone_scn.instance()
	inst.frames = $Sprite.frames
	inst.animation = "dying"
	inst.global_position = global_position
	inst.rotation = $Sprite.rotation
	inst.get_node("AudioStreamPlayer").stream = death_sound
	inst.get_node("AudioStreamPlayer").play()
	get_node("../").add_child_below_node(self,inst)
	visible=false
	queue_free()

func boost(sec:float)->void:
	pass
	#RIP perfect boost formula :(
	#boost += sec * 4 # 1.5=2; 1.25 = 4; 1=1; proportionaltaet zu boost speed multiplier
	#print("boost set")

func _draw()->void:
	if(bBuffed):
		draw_circle(Vector2(),15,ColorN("green"))
	if(hp<hp_max):
		draw_rect(Rect2(Vector2(-15,-25),Vector2(30,4)),ColorN("black",0.5))
		draw_rect(Rect2(Vector2(-15,-25),Vector2(30*hp/hp_max,4)),ColorN("red"))

func _process(delta: float) -> void:
	update()
	#boost = 0
#	if(is_instance_valid(attack)):
#		attack.step(delta)
	if(is_instance_valid(ability)):
		ability.step(delta)
	#Sprite.rotation = global_position.angle_to(target.global_position)
	if(!bFinished):
		walk(delta)
	#boost = clamp(boost-delta,0.0,99999.9)
#	if(order_pos == 2 && boost != 0):
#		#print(boost)

func walk(delta:float)->void:
	if(typeof(path) == TYPE_NIL):
		path = get_node("../").troop_path
		#print(self," updated path")
	move_along_path(delta*speed*(1.25 if boost > 0 else 1))

func move_along_path(distance:float)->void:
	if($Sprite/Probe1.is_colliding() || $Sprite/Probe2.is_colliding() || $Sprite/Probe3.is_colliding()):
		#print("Colliding")
		return
	if(typeof(path) == TYPE_NIL):
		print("no path set!")
		return
	var start_pos:=position
	var st :=position
	for i in range(path.size()):
		var dist_to_next:= start_pos.distance_to(path[0])
		if(distance <= dist_to_next && distance >= 0.0): #can move less than next point, therefore move just towards
			position = start_pos.linear_interpolate(path[0], distance/dist_to_next)
			break
		distance -= dist_to_next
		start_pos = path[0]
		path.remove(0)
		if(path.size() == 0):
			attack_computer()
	$Sprite.rotation = position.angle_to_point(st)

func attack_computer()->void:
	assert(!bFinished)
	bFinished = true
	while(true):
		get_node("../").get_node("Computer").computer_damage(computer_dmg)
		yield(get_tree().create_timer(0.1), "timeout")

#ability 1 functionality + effect strength
func ab1(val:bool)->void:
	if(val && !bAb1):
		speed_og = speed
		speed = speed * .85
		bAb1 = true
		#hp -= 
	else:
		speed = speed_og
		bAb1 = false