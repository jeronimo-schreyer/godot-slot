extends Spatial

onready var http = get_parent().get_node("HTTPRequest")

var fsm: Node
var ramp = preload("res://core/Rampa.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	print("Main::enter")

func play():
	
	#start reels
	$"Main UI/reel/Reels".startSpin()
	
	# send request
	var req = yield(http.send("spin"), "finished")
	#print(req.result.TOTALPAY)
	
	# stop reels on stop points
	yield($"Main UI/reel/Reels".stopSpin(req.result.STOP), "all_reels_stopped")
	
	# show ramp
	if req.result.TOTALPAY > 0:
		var ramp_node = ramp.instance()
		add_child(ramp_node)
		
		yield(ramp_node.ramp(req.result.TOTALPAY), "finished")
	
	# update ui values
	$"Main UI".update_jackpot(req.result)
	$"Main UI".update_balance(req.result)
	$"Main UI".update_win(req.result)
	
	# show winning combinations
	
	#fsm.exit_state()
