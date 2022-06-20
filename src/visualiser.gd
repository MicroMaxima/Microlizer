extends Node2D

onready var main = get_node("/root/Main")
onready var stream = get_node("/root/Main/LiveAudio")

var default_font
var total_w = 800
var total_h = 200
var w_interval
	
# Called when the node enters the scene tree for the first time.
func _ready():
	default_font = Control.new().get_font("font")
	w_interval = total_w / stream.definition

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update() # calls draw

func _draw():
	var draw_pos = Vector2(0, 0)
	var text_range = ""

	draw_line(Vector2(0, -total_h), Vector2(total_w, -total_h), Color.dodgerblue, 2.0, true)

	for i in range(stream.definition):
		draw_line(draw_pos, draw_pos + Vector2(0, -stream.histogram[i] * total_h), Color.dodgerblue, 4.0, true)
		draw_pos.x += w_interval

	#draw_set_transform ( Vector2(-stream.total_w, 0), 0, Vector2.ONE )
	draw_set_transform ( Vector2.ZERO, deg2rad(90), Vector2.ONE )
	draw_pos = Vector2(0, 0)
	for i in range(stream.definition):
		text_range = str(stream.freqs_low[i]) + " - " + str(stream.freqs_high[i])
		draw_string(default_font, Vector2(draw_pos.x + 5, draw_pos.y + 5), text_range, Color.dodgerblue)
		#draw_set_transform ( Vector2.ZERO, 0, Vector2.ONE )
		draw_pos.y -= w_interval
