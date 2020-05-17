extends Control

var payout = 10000
signal finished

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_method($".", "updatePayout", 0, payout, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updatePayout(value):
	$dialog/VBoxContainer/prize.text = "$%s" % Globals.price_format(value, ".", ",")
