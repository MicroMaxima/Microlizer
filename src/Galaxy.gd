extends Particles

onready var main = get_node("/root/Main")
onready var stream = get_node("/root/Main/LiveAudio")

var colour_index = 0
var mat = SpatialMaterial.new()

var colour_time = 0
var colour_time_max = 1
var colour_time_step = 0.001
var colour_time_grad = Gradient.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	colour_index = main.get_current_colour_index()
	mat = SpatialMaterial.new()
	mat.emission_enabled = true
	mat.emission_energy = main.get_current_colour_preset()[2] + 6 # start off black
	draw_pass_1.surface_set_material( 0, mat )
	set_colours(main.get_current_colour_preset()[1])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (colour_index != main.get_current_colour_index()):
		colour_time_grad.set_color(0, main.get_colour_preset(colour_index)[1] )
		colour_time_grad.set_color(1, main.get_current_colour_preset()[1] )
		set_colours( colour_time_grad.interpolate( colour_time ) )
		colour_time += colour_time_step + delta
		if colour_time >= colour_time_max:
			colour_index = main.get_current_colour_index()
			colour_time = 0 # reset
	#mat.emission_energy = main.get_current_colour_preset()[2] * (stream.histogram.max() * 8) # pulse option or overkill?

# sets colours of all child instances
func set_colours(colour):
	mat.emission = colour

