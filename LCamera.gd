extends Camera2D

var L

var trauma:float=0.0 setget set_trauma
#export(bool) var bUseSimplex := true
export(int) var traumaPow := 3 #shake = trauma^traumaPow 
export(bool) var bDisplayDebug := false #trauma meter
export(Vector2) var maxOffset := Vector2(10,10)
export(int) var maxAngle := 25
export(float) var traumaDecreaseModifier := 1.0
var simplex = OpenSimplexNoise.new()
func _ready()->void:
	randomize()
	#SimplexNoiseSetup
	simplex.seed = randi()
	simplex.octaves = 4
	simplex.period = 20.0
	simplex.persistence = 0.8

	make_current()

func add_trauma(amount:float)->void:
	set_trauma(trauma+amount)

func set_trauma(val:float)->void:
	#print("setget called")
	if(val > 1.0 || val < 0.0):
		#print("Warning: trying to increase traume by more than 1.0 or less two. Attempt blocked")
		return
	trauma = clamp(val,0.0,1.0)

func _physics_process(delta:float)->void:
	#screenshake
	var shake:float = pow(trauma,traumaPow)
	var time:int = OS.get_ticks_usec()
	var noiseX:float = simplex.get_noise_2d(time,0)
	var noiseY:float = simplex.get_noise_2d(time,100)
	var noiseA:float = simplex.get_noise_2d(time,200)
	offset.x = maxOffset.x * shake * noiseX
	offset.y = maxOffset.y * shake * noiseY
	rotation_degrees = (maxAngle * shake * noiseA) -90

	# modify trauma
	set_trauma(trauma-0.005*traumaDecreaseModifier)

	update()

func _draw()->void:
	if(bDisplayDebug):
		draw_rect(Rect2(Vector2(),Vector2(30,300)),"#474747")
		draw_rect(Rect2(Vector2(),Vector2(30,trauma * 300)),"#0000ff")
