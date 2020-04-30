extends Control

signal spin

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateJackpotValues(result):
	#$"VBoxContainer/Top Panel/Jackpot 1".updateValue(result.JACKPOT1)
	#$"VBoxContainer/Top Panel/Jackpot 2".updateValue(result.JACKPOT2)
	print(result.JACKPOT)


func _on_spin_pressed():
	emit_signal("spin")
