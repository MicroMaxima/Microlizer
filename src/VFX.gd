extends ColorRect

onready var main = get_node("/root/Main")
onready var stream = get_node("/root/Main/LiveAudio")
onready var chroma = get_node("/root/Main/CanvasLayer/VFX")

var scale_amount : float = 0.35 # 0-1 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	chroma.get_material().set_shader_param("size", 1 - (stream.histogram[0] * scale_amount))

