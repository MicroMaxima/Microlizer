extends Spatial

onready var main = get_node("/root/Main")
onready var stream = get_node("/root/Main/LiveAudio")

var freq_trigger_start = 35
var freq_trigger_end = 19500

var freq_index_start = 0
var freq_index_end = 0
var freq_index_size =0

var colour_index = 0

var colour_time = 0
var colour_time_max = 1
var colour_time_step = 0.001
var colour_time_grad_start = Gradient.new()
var colour_time_grad_end = Gradient.new()

var children_r = Array()
var children_l = Array()
var origin_size
var max_scale = 1700

# Called when the node enters the scene tree for the first time.
func _ready():
	origin_size = scale.normalized()
	freq_index_start = stream.get_index_from_frequency(freq_trigger_start)
	freq_index_end = stream.get_index_from_frequency(freq_trigger_end)
	var res = preload("res://scenes/FreqMeter.tscn")
	freq_index_size = freq_index_end - freq_index_start + 1
	children_r = create_ring_from_scene(res, translation, 6, freq_index_size, 190, 110)
	children_l = create_ring_from_scene(res, translation, 6, freq_index_size, 170, -110)
	
	# main material setup
	for i in range(children_r.size()):
		var mat = SpatialMaterial.new()
		#mat.set_flag(SpatialMaterial.FLAG_UNSHADED, true)
		mat.emission_enabled = true
		mat.emission_energy = 2
		children_r[i].set_material(mat)
		children_l[i].set_material(mat)
	
	colour_index = main.get_current_colour_index()
	set_colours(main.get_current_colour_preset()[0], main.get_current_colour_preset()[1], main.get_current_colour_preset()[2])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if (colour_index != main.get_current_colour_index()):
		colour_time_grad_start.set_color(0, main.get_colour_preset(colour_index)[0] )
		colour_time_grad_start.set_color(1, main.get_current_colour_preset()[0] )
		colour_time_grad_end.set_color(0, main.get_colour_preset(colour_index)[1] )
		colour_time_grad_end.set_color(1, main.get_current_colour_preset()[1] )
		set_colours( 
			colour_time_grad_start.interpolate( colour_time ), 
			colour_time_grad_end.interpolate( colour_time ),
			main.get_current_colour_preset()[2]
		)
		colour_time += colour_time_step + delta
		if colour_time >= colour_time_max:
			colour_index = main.get_current_colour_index()
			colour_time = 0 # reset

	for i in range(children_r.size()):
		var current_scale =  (stream.histogram[freq_index_start + i] * max_scale) 
		children_r[i].scale = origin_size + Vector3(0, 1, 0) * current_scale
		children_l[i].scale = origin_size + Vector3(0, 1, 0) * current_scale

# create a ring of instances objects based on params
func create_ring_from_scene(obj, pivot_point: Vector3, distance: float, num: int, start_deg: float = 0, end_deg: float = 360):
	var inst_array = Array()
	for i in range(num):
		var pivot_axis = Vector3(0, 1, 0) # axis to rotate from 
		var new_inst = obj.instance()
		inst_array.append(new_inst)
		
		add_child(new_inst)

		new_inst.translation = Vector3(0, 0, distance) # move away by distance
		var degrees = start_deg + (end_deg / num) * i
		rotate_from_pivot(new_inst, pivot_point, pivot_axis, degrees)
	return inst_array

# rotates an object from a pivot axis to a number of degrees
func rotate_from_pivot(obj, pivot_point: Vector3, pivot_axis: Vector3, degrees: float):
	var rot = deg2rad(degrees) + obj.rotation.y 
	var tStart = pivot_point
	obj.global_translate (-tStart)
	obj.transform = obj.transform.rotated(pivot_axis, -rot)
	obj.global_translate (tStart)

# sets colours of all child instances
func set_colours(colour_start, colour_end, energy):
	var grad = Gradient.new()
	var col = float(0)
	grad.set_color(0, colour_start )
	grad.set_color(1, colour_end )
	for i in range(children_r.size()):
		col = float(i)/float(children_r.size())
		children_r[i].get_material().emission = grad.interpolate( col )
		children_l[i].get_material().emission = grad.interpolate( col )
		children_r[i].get_material().emission_energy = energy
		children_l[i].get_material().emission_energy = energy

