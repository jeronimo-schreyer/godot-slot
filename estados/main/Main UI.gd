extends Control

signal spin

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_jackpot(result):
	$jackpot/value.update_value(result.JACKPOT)

func update_balance(result):
	$main_menu/balance.update_value(result.BALANCE)

func update_win(result):
	$"main_menu/total win".update_value(result.TOTALPAY)

func set_ui_enable(enabled):
	$"main_menu/bet down".disabled = !enabled
	$"main_menu/bet up".disabled = !enabled
	$"main_menu/double up".disabled = !enabled
	$main_menu/auto.disabled = !enabled
	$main_menu/info.disabled = !enabled
	$main_menu/settings.disabled = !enabled
	$main_menu/spin.disabled = !enabled
	$main_menu/turbo.disabled = !enabled

func is_turbo():
	return $main_menu/turbo.pressed

func _on_spin_pressed():
	emit_signal("spin")
