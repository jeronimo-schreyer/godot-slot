extends HBoxContainer

signal all_reels_stopped

# Declare member variables here.
var reels = []
var reels_stopped = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reels = get_children()

func startSpin():
	for reel in reels:
		reel.startSpin()
		yield(get_tree().create_timer(.12), "timeout")

func stopSpin(stop_points):
	for i in range(reels.size()):
		reels[i].stopSpin(stop_points[i])
	
	return self

func _on_reel_stop():
	reels_stopped = reels_stopped + 1
	if reels_stopped == reels.size():
		reels_stopped = 0
		emit_signal("all_reels_stopped")
