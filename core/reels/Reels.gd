extends HBoxContainer

signal all_reels_stopped
signal show_winning_lines_finished

# Declare member variables here.
var reels = []
var reels_stopped = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reels = get_children()

func start_spin():
	for reel in reels:
		reel.start_spin()
		
		# dont start them all at once
		yield(get_tree().create_timer(.12), "timeout")

func stop_spin(stop_points, turbo = false):
	for i in range(reels.size()):
		reels[i].stop_spin(stop_points[i], turbo)
	
	return self

func _on_reel_stop():
	reels_stopped = reels_stopped + 1
	if reels_stopped == reels.size():
		reels_stopped = 0
		emit_signal("all_reels_stopped")

func show_winning_lines(payouts, loop):
	for payout in payouts:
		for i in range(reels.size()):
			var symbols_to_animate = []
			for j in range(0, 20, 5): # reels.size()):
				#if payout.POSITIONS.has(i + j):
				var position_coord = i + j
				if payout.POSITIONS[0] == position_coord:
					symbols_to_animate.push_back(int(floor(j / 5)))
			
			reels[i].animate_symbols(symbols_to_animate, payout.SYMBOL)
	
	return self
