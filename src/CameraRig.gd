extends Position3D

var speed = 0.1
var frequency_x = 1.0 * speed
var amplitude_x = 100
var frequency_y = 3.3333333 * speed
var amplitude_y = 40
var time = 0
var origin_location

# Called when the node enters the scene tree for the first time.
func _ready():
	origin_location = translation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var movement_x = cos(time * frequency_x) * amplitude_x
	var movement_y = cos(time * frequency_y) * amplitude_y
	translation = Vector3(origin_location.x  + movement_x * delta, origin_location.y + movement_y * delta, origin_location.z)
	look_at( get_node("/root/Main/CamFocus").translation, Vector3(0,1,0) )

