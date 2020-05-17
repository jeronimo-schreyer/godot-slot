extends Spatial

var fsm: Node

onready var http = get_parent().get_node("HTTPRequest")

var ramp = preload("res://rampa/Rampa.tscn")
var final_ramp = preload("res://ui/Freespin Win.tscn")
var freespins_left = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter(request):
	#print("Free Spin::enter")
	freespins_left = request.result.FREESPINS_LEFT
	play()

func play():
	
	# update freespins left UI
	$"Freespin UI/main_menu/spin/left".text = String(freespins_left - 1)
	
	#start reels
	$"Freespin UI/reel/Reels".startSpin()
	
	# send request
	var req = yield(http.send("freespin"), "finished")
	
	# stop reels on stop points
	yield($"Freespin UI/reel/Reels".stopSpin(req.result.STOP), "all_reels_stopped")
	
	# show ramp
	if req.result.TOTALPAY > 0:
		var ramp_node = ramp.instance()
		add_child(ramp_node)
		
		yield(ramp_node.ramp(req.result.TOTALPAY), "finished")
	
	# show winning combinations
	
	# update freespins left
	freespins_left = req.result.FREESPINS_LEFT
	
	# update ui values
	$"Freespin UI".update_balance(req.result)
	$"Freespin UI".update_win(req.result)
	
	if freespins_left == 0:
		var ramp_node = final_ramp.instance()
		ramp_node.payout = req.result.FS_PAYOUT
		add_child(ramp_node)
		
		yield(ramp_node, "finished")
	
	fsm.exit_state()
