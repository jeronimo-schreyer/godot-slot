extends Control

signal reel_stop
signal anim_finished

export (String) var strip # symbols separated by comma (,)
var strip_symbols = []
var symbol_nodes = []
var strip_index = 0 # current place in the strip
var stop_point = -1
var forced = false

onready var stateMachine = $AnimationTree.get("parameters/playback")

const STATE_IDLE = "Idle"
const STATE_SPINNING = "Spinning"

# Called when the node enters the scene tree for the first time.
func _ready():
	strip_symbols = strip.split(",")
	
	for child in $VBoxContainer.get_children():
		symbol_nodes.push_back(child)
	
	update_symbols(false, 0)

func update_symbols(blurred, update_counter = 1):
	strip_index = (strip_index + update_counter) % (strip_symbols.size() - symbol_nodes.size()) 
	for i in range(symbol_nodes.size()):
		var sym = symbol_nodes[i]
		var sym_index = strip_index + symbol_nodes.size() - i
		sym.update_symbol("sym_" + strip_symbols[sym_index], blurred)
	
	if strip_index == stop_point:
		stop_point = -1
		stateMachine.travel(STATE_IDLE)
		
		# regenerate strip if forced
		if forced:
			strip_symbols = strip.split(",")
		else: # stop timeout
			$Timeout.stop()
	
func force(_strip_index):
	forced = true
	for i in range(symbol_nodes.size()):
		var sym_index = strip_index + symbol_nodes.size() - i
		var symbol = strip_symbols[_strip_index + symbol_nodes.size() - i]
		strip_symbols.insert(sym_index + 1, symbol)
	stop_point = strip_index + symbol_nodes.size()

func start_spin(turbo):
	var anim_speed = 64 if turbo else 1
	$AnimationPlayer.playback_speed = anim_speed
	stateMachine.travel(STATE_SPINNING)

func stop_spin(stop_point, turbo):
	if turbo:
		force(stop_point)
	else:
		self.stop_point = stop_point
		$Timeout.start()

func animate_symbols(symbol_positions):
	for i in range(symbol_nodes.size()):
		if symbol_positions.has(i - 1):
			symbol_nodes[i].animate()
			symbol_nodes[i].modulate = Color(1, 1, 1, 1)

func is_symbol(position, symbol):
	return true

func _on_reel_timeout():
	force(stop_point)
