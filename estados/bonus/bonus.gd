extends Spatial

var fsm: Node

onready var http = get_parent().get_node("HTTPRequest")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	print("Bonus::enter")

func play(selection):
	if selection.empty():
		selection = "1"
		
	# send request
	var req = yield(http.send("bonus", [
		{ "selection": selection }
	]), "finished")
	
	fsm.exit_state()
