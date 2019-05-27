extends Area2D

var target

export(int) var speed = 100
export(int) var damage = 15

var bUsed = false

func _ready() -> void:
	randomize()
	#$Sprite.frame = randi()%2 
	set_process(false)
	connect("area_entered",self,"_on_area_entered")
	$Sprite.rotation_degrees = 10-(randi() % 21)
	var scalerand = randf() * 0.4
	$Sprite.scale = Vector2(1.8 + scalerand,1.8 + scalerand)

func _on_area_entered(area:Area2D)->void:
	if(!bUsed && area.get_node("../") == target):
		bUsed = true
		area.get_node("../").take_damage(damage)
		visible = false
		queue_free()


func _process(delta: float) -> void:
	if(!is_instance_valid(target)):
		print("attack scenes target invalid, projectile is destroying itself")
		queue_free()
	else:
		global_position += (((target.global_position - global_position) * speed * delta))
