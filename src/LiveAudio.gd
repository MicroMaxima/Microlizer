# thanks to Gonkee for a large part of this node
# https://www.youtube.com/watch?v=AwgSICbGxJM
# I modified a fair bit including pulling out frequency setup to _ready from _process

extends AudioStreamPlayer

onready var spectrum = AudioServer.get_bus_effect_instance(1, 1)

var definition = 50

var min_freq = 20 # lowest frequency in Hz
var max_freq = 20000 # highest freqnecy in Hz

var max_db = -8 # max db clamping
var min_db = -50 # min db clamping

var histogram = []
var previous = []
var freqs_low = []
var freqs_high = []

# Called when the node enters the scene tree for the first time.
func _ready():
	max_db += volume_db # modify max vol if stream manually set in inspector
	min_db += volume_db # modify min vol if stream manually set in inspector
	
	var freq = min_freq
	var interval = (max_freq - min_freq) / definition # size of chunk sample range in Hz
	
	for i in range(definition): # intialise the histogram
		histogram.append(0)
		previous.append(0)
		freqs_low.append(0)
		freqs_high.append(0)
		
		# adjust for wavelength as freqency scales
		var freqrange_low = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_low = pow(freqrange_low, 4) # the scale
		freqrange_low = lerp(min_freq, max_freq, freqrange_low) # adjust back based on min/max

		freq += interval # frequency end Hz
		
		var freqrange_high = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_high = pow(freqrange_high, 4) # the scale
		freqrange_high = lerp(min_freq, max_freq, freqrange_high) # adjust back based on min/max

		freqs_low[i] = freqrange_low
		freqs_high[i] = freqrange_high

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mag = 0.0

	# copy current to previous
	previous = [] + histogram # use this method to copy values from array object

	for i in range(definition):
		mag = spectrum.get_magnitude_for_frequency_range(freqs_low[i], freqs_high[i])
		mag = linear2db(mag.length())
		mag = (mag - min_db) / (max_db - min_db) # compress mag db range - result is 0-1 float
		
		mag += 0.3 * float(freqs_high[i] - min_freq) / float(max_freq - min_freq)
		# add limits
		#mag = clamp(mag, 0.05, 1)
		mag = clamp(mag, 0, 1)

		# look at how to use delta? https://www.construct.net/en/blogs/ashleys-blog-2/using-lerp-delta-time-924
		if (histogram[i] < mag):
			histogram[i] = lerp(histogram[i], mag, 0.5)
		else:
			histogram[i] = lerp(histogram[i], mag, 0.3)
		#histogram[i] = mag
		#print(mag, histogram[i])

func get_index_from_frequency(frequency: float):
	for i in range(definition):
		if freqs_low[i] <= frequency && freqs_high[i] > frequency:
			return i
