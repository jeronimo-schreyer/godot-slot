extends Node

var current
var next
var node

var last_request

onready var states = {
	"bonus" : preload("res://estados/bonus.tscn"),
	"Spin" : preload("res://estados/main.tscn"),
	"Freespin": preload("res://estados/freespin.tscn"),
	"doubleup" : preload("res://estados/double up.tscn"),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# set window minium size
	OS.min_window_size = Vector2(
		ProjectSettings.get("display/window/size/min_width"),
		ProjectSettings.get("display/window/size/min_height")
	)
	
	if states.size() > 0:
		next = states.keys()[0]
		enter_state()

func enter_state():
	if node != null:
		node.queue_free()
	
	node = states[next].instance()
	current = next
	node.fsm = self
	node.call_deferred("enter", last_request)
	add_child(node)

func switch_state(state):
	next = state

func exit_state():
	if next != null:
		if current == next:
			node.call_deferred("enter", last_request)
		else:
			enter_state()

func http_finished(request):
	last_request = request
	switch_state(request.result.NEXT_STATE)


func http_error(responseCode):
	print("HTTP Error, response code: %i" % responseCode)
