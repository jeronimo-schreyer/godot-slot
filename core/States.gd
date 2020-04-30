extends Node

var current
var next

onready var states = {
	"main" : preload("res://estados/main.tscn"),
	"bonus" : preload("res://estados/bonus.tscn"),
	"freespin": preload("res://estados/freespin.tscn"),
	"doubleup" : preload("res://estados/double up.tscn"),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if states.size() > 0:
		next = states[states.keys()[0]]
		enter_state()

func enter_state():
	if current != null:
		current.queue_free()
	
	current = next.instance()
	current.fsm = self
	current.enter()
	add_child(current)

func switch_state(state):
	next = states[state]

func exit_state():
	if next != null:
		enter_state()

func send_request():
	pass

func http_finished(request):
	pass
	#switch_state(request.result.NEXT_STATE)


func http_error(responseCode):
	print("HTTP Error, response code:" + responseCode)