extends HBoxContainer

# Declare member variables here.
var reels = []

# Called when the node enters the scene tree for the first time.
func _ready():
	reels = get_children()

func startSpin():
	for reel in reels:
		reel.startSpin()

func stopSpin(stop_points):
	for reel in reels:
		reel.stopSpin()
