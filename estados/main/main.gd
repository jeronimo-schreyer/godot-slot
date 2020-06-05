extends Spatial

onready var http = get_parent().get_node("HTTPRequest")

var fsm: Node
var ramp = preload("res://rampa/Rampa.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter(request):
	print("Main::enter")

func play():
	
	var is_turbo_play = $"Main UI".is_turbo()
	
	# disable UI
	$"Main UI".set_ui_enable(false)
	
	#start reels
	$"Main UI/reel/Reels".start_spin(is_turbo_play)
	
	# send request
	var req = yield(http.send("spin"), "finished")
	#print(req.result.TOTALPAY)
	
	# stop reels on stop points
	yield($"Main UI/reel/Reels".stop_spin(req.result.STOP, is_turbo_play), "all_reels_stopped")
	
	if req.result.TOTALPAY > 0:
		# show all winning lines
		$"Main UI/reel/Reels".show_all_winning_lines(req.result.PAYOUTS)
		
		# show ramp
		var ramp_node = ramp.instance()
		add_child(ramp_node)
		yield(ramp_node.ramp(req.result.TOTALPAY), "finished")
		
		#if !is_autoplay:
		#	# show winning lines
		#	$"Main UI/reel/Reels".show_winning_lines(req.result.PAYOUTS)
		$"Main UI/reel/Reels".show_winning_lines(req.result.PAYOUTS)
	
	# update ui values
	$"Main UI".update_jackpot(req.result)
	$"Main UI".update_balance(req.result)
	$"Main UI".update_win(req.result)
	
	# show winning combinations
	
	# enable UI
	$"Main UI".set_ui_enable(true)
	
	fsm.exit_state()
