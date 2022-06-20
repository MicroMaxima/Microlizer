# Written by MicroMaxima - https://twitter.com/Micromaxima

extends Node

onready var stream = get_node("/root/LiveAudio")

var colour_presets = []
var colour_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func get_colour_presets():
	if colour_presets.empty():
		set_colour_presets()
	return colour_presets

func get_colour_preset(i):
	if colour_presets.empty():
		set_colour_presets()
	return colour_presets[ i ]

func set_colour_presets():
	colour_presets.append( [Color.white, Color.white, 1.5] ) # white
	colour_presets.append( [Color("ff007f"), Color("2e00ff"), 2] ) # Wenna purple
	colour_presets.append( [Color("0e00ff"), Color("0086ff"), 2] ) # aqua blue
	colour_presets.append( [Color("db36a4"), Color("f7ff00"), 2] ) # Alihossein
	colour_presets.append( [Color("0062ff"), Color("f90000"), 2] ) # hellfire blue 
	colour_presets.append( [Color("48ff00"), Color("f1ff00"), 1.3] ) # green
	colour_presets.append( [Color("ffae00"), Color("ff3a00"), 1.7] ) # lava
	colour_presets.append( [Color("ffd700"), Color("0057b7"), 1.7] ) # Slava Ukraini

func get_current_colour_index():
	return colour_index

func set_current_colour_index(index: int):
	colour_index = index

func get_current_colour_preset():
	return get_colour_presets()[ colour_index ]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


