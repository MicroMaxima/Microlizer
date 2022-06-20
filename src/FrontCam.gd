extends Camera

onready var main = get_node("/root/Main")
onready var stream = get_node("/root/Main/LiveAudio")

var frequency = 60
var amplitude = 0
var max_amplitude = 1.5
var time = 0
var origin_location

# Called when the node enters the scene tree for the first time.
func _ready():
	origin_location = translation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# use lowest frequency [0] for cam shake effect
	if (stream.histogram[0] < stream.previous[0] - 0.0001) && stream.previous[0] > 0.5:
		amplitude = max_amplitude * stream.previous[0]
	if amplitude <= 0:
		amplitude = 0
	else:
		time += delta
		var movement = cos(time * frequency) * amplitude
		translation = Vector3(origin_location.x, origin_location.y + movement * delta, origin_location.z)
