extends Spatial

var fsm: Node

onready var http = get_parent().get_node("HTTPRequest")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	print("Double Up::enter")

func play(selection):
	
	# send request
	var req = yield(http.send("doubleup", [
		{ "selection": selection }
	]), "finished")
	
	#print(req.result.TOTALPAY)
	
	# stop reels on stop points
	#$Environment/Reel/Viewport/Reels.stopSpin(req.result.STOP)
	
	# show ramp
	
	# show winning combinations
	
	# update jackpot values
	#$UI.updateJackpotValues(req.result)
	
	fsm.exit_state()
