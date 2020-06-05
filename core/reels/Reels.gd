extends HBoxContainer

signal all_reels_stopped
signal show_winning_lines_finished

# Declare member variables here.
var reels = []
var reels_stopped = 0
var current_payouts
var current_winning_line

# Called when the node enters the scene tree for the first time.
func _ready():
	for reel in get_children():
		if reel is Control:
			reels.push_back(reel)

func start_spin(turbo):
	for reel in reels:
		reel.start_spin(turbo)
		
		# dont start them all at once
		var timeout = .06 if turbo else .12
		yield(get_tree().create_timer(timeout), "timeout")

func stop_spin(stop_points, turbo):
	for i in range(reels.size()):
		reels[i].stop_spin(stop_points[i], turbo)
	
	return self

func _on_reel_stop():
	reels_stopped = reels_stopped + 1
	if reels_stopped == reels.size():
		reels_stopped = 0
		emit_signal("all_reels_stopped")

func show_line_by_line():
	current_winning_line = (current_winning_line + 1) % current_payouts.size()
	var pay_positions := PoolIntArray(current_payouts[current_winning_line].POSITIONS)
	$"AnimationPlayer/Line Payout".text = "$ %s" % Globals.price_format(current_payouts[current_winning_line].PAY, ".", ",")
	animate_symbols(pay_positions)

func animate_symbols(positions):
	for i in range(reels.size()):
		var symbols_to_animate = []
		for j in range(0, 20, reels.size()):
			var symbol_position = i + j
			var node_position = int(floor(j / reels.size()))
			reels[i].symbol_nodes[node_position + 1].modulate = Color(1, 1, 1, .2)
			if Array(positions).has(symbol_position):
				# if reels[i].is_symbol(symbol_position, payout.SYMBOL):
				symbols_to_animate.push_back(node_position)
				# else:
				#	print("Reels::show_all_winning_lines - %d symbol is not %s", (symbol_position, payout.SYMBOL))
		
		reels[i].animate_symbols(symbols_to_animate)

func show_winning_lines(payouts):
	current_winning_line = 0
	current_payouts = payouts
	$AnimationPlayer.play("line by line")

func show_all_winning_lines(payouts):
	var pay_positions := PoolIntArray()
	for payout in payouts:
		pay_positions.append_array(payout.POSITIONS)
	
	animate_symbols(pay_positions)
	return self
