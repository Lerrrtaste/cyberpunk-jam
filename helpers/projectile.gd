extends Area2D

var target

export(int) var speed = 100
export(int) var damage = 15

var bUsed = false

func _ready() -> void:
	randomize()
	$Sprite.frame = randi()%2 
	set_process(false)
	connect("area_entered",self,"_on_area_entered")

func _on_area_entered(area:Area2D)->void:
	if(!bUsed && area.get_node("../") == get_node("../").get_node("../").target):
		bUsed = true
		area.get_node("../").take_damage(damage)
		visible = false
		queue_free()


func _process(delta: float) -> void:
	if(!is_instance_valid(get_node("../").get_node("../").target)):
		print("attack scenes target invalid, projectile is destroying itself")
		queue_free()
	else:
		global_position += (get_node("../").get_node("../").target.global_position - global_position).normalized() * speed * delta
