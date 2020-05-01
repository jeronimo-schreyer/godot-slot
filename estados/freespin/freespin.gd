extends Spatial

var fsm: Node

onready var http = get_parent().get_node("HTTPRequest")

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	play()

func enter():
	#print("Free Spin::enter")
	pass

func play():
	
	#start reels
	$"Freespin UI/reel/Reels".startSpin()
	
	# send request
	var req = yield(http.send("freespin"), "finished")
	yield(get_tree().create_timer(2), "timeout")
	print(req.result.TOTALPAY)
	
	# stop reels on stop points
	$"Freespin UI/reel/Reels".stopSpin(req.result.STOP)
	
	# show ramp
	
	# show winning combinations
	
	# update jackpot values
	#$UI.updateJackpotValues(req.result)
	
	fsm.exit_state()
