extends Control

const WIN = 500
const BIG_WIN = 1000
const SUPER_BIG_WIN = 5000

signal finished

onready var state = $AnimationTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready():
	#state.travel("Super Win")
	pass # Replace with function body.

func _process(delta):
	pass

func updatePayout(value):
	$Payout/Label.text = "%d" % ceil(value)

func get_total_duration(anims):
	var duration = 0
	for anim in anims:
		duration += $AnimationPlayer.get_animation(anim).length
	return duration

func ramp(payout):
	assert(payout != 0)
	
	var animations = [] 
	
	# Get coorect ramp animation
	if payout >= SUPER_BIG_WIN:
		state.travel("Super Win")
		animations = ["Win Short", "Big Win Short", "Super Win"]
	elif payout >= BIG_WIN:
		state.travel("Big Win")
		animations = ["Win Short", "Big Win"]
	elif payout >= WIN:
		state.travel("Win")
		animations = ["Win"]
	else:
		state.travel("Ramp")
		animations = ["Ramp"]
	
	# Tween payout number
	$Payout/Label/Tween.interpolate_method($".", "updatePayout", 0, payout, get_total_duration(animations), Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	return self
