extends Spatial

onready var main = get_node("/root/Main")
onready var stream = get_node("/root/Main/LiveAudio")

var origin_size
var amplitude = 0
var max_amplitude = 10

var freq_trigger = 70 #Hz
var freq_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	origin_size = scale
	freq_index = stream.get_index_from_frequency(freq_trigger)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var max_scale = 0.3
	var current_scale =  (stream.histogram[freq_index] * max_scale)
	var new_scale = Vector3(
			origin_size.x * current_scale, 
			origin_size.y * current_scale, 
			origin_size.z * current_scale
		)
	scale = origin_size + new_scale
