extends Control

signal reel_stop

export (String) var strip # symbols separated by comma (,)
var strip_symbols = []
var symbol_nodes = []
var strip_index = 0 # current place in the strip

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

func startSpin():
	stateMachine.travel(STATE_SPINNING)

func stopSpin():
	stateMachine.travel(STATE_IDLE)
