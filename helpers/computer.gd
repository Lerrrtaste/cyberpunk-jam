extends Sprite

export(int) var hp_max:int = 1000
var hp = hp_max

onready var area_range = get_node("../AreaRange")
onready var timer = $Cooldown
var projectile_scn = preload("res://helpers/projectile.tscn")

var cake = "0111010001101000011001010010000001100011011000010110101101100101001000000110100101110011001000000110000100100000011011000110100101100101"
var cidx := 0

var targets:Array

func _ready() -> void:
	$AudioStreamPlayer.stream = preload("res://Assets/sfx/computer_firing.wav")
	$Area2D.connect("area_entered",self,"_on_area_entered")
	$Area2D.connect("area_exited",self,"_on_area_exited")
	timer.connect("timeout",self,"_on_timeout")

func _on_area_entered(area:Area2D)->void:
	targets.append(area.get_node("../"))
	
func _on_area_exited(area:Area2D)->void:
	for i in targets.size():
		if(area.get_node("../") == targets[i]):
			targets.remove(i)
			return

func _process(delta: float) -> void:
	update()

#copied from attack 0
func _on_timeout()->void:
	for t in targets:
		var inst = projectile_scn.instance()
		add_child(inst)
		$AudioStreamPlayer.play()
		if(cidx >= cake.length()):
			cidx = 0
		inst.get_node("Sprite").frame = 0 if cake[cidx] == "0" else 1
		cidx += 1
		inst.target = t
		inst.damage = 10
		inst.global_position = global_position
		inst.set_process(true)

func computer_damage(dmg:int)->void:
	if(hp-dmg <= 0):
		pass #GAME OVER TODO
	else:
		hp -= dmg
		print("damaged really")

func _draw() -> void:
	draw_rect(Rect2(Vector2(-50,-35),Vector2(100,10)),ColorN("black",1.0))
	draw_rect(Rect2(Vector2(-50,-35),Vector2(100*hp/hp_max,10)),ColorN("green"))