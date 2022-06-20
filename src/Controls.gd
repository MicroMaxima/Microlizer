extends Node

onready var main = get_node("/root/Main")
onready var stream = get_node("/root/Main/LiveAudio")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.scancode:
			KEY_0: # colour preset changes
				main.set_current_colour_index(0)
			KEY_1: # colour preset changes
				main.set_current_colour_index(1)
			KEY_2: # colour preset changes
				main.set_current_colour_index(2)
			KEY_3: # colour preset changes
				main.set_current_colour_index(3)
			KEY_4: # colour preset changes
				main.set_current_colour_index(4)
			KEY_5: # colour preset changes
				main.set_current_colour_index(5)
			KEY_6: # colour preset changes
				main.set_current_colour_index(6)
			KEY_7: # colour preset changes
				main.set_current_colour_index(7)
			KEY_K: # show these keyboard controls
				get_node("./UI").visible = !get_node("./UI").visible
			KEY_G: # galaxy visibility toggle
				get_node("/root/Main/Galaxy").emitting = !get_node("/root/Main/Galaxy").emitting
			KEY_F: # fullscreen toggle
				OS.window_fullscreen = !OS.window_fullscreen
			KEY_D: # debug visibility toggle
				get_node("/root/Main/Debug").visible = !get_node("/root/Main/Debug").visible
			KEY_Q: # show these keyboard controls
				get_tree().quit()
