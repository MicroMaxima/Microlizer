extends OmniLight

var time = 0
var frequency = 1
var amplitude = 0.5
var movement = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	movement = cos(time * frequency) * amplitude
	light_energy = 2.0 + (movement * 4)
