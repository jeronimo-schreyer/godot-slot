extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var value = 0
export var format = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	print_value(value)

func print_value(_value):
	var _format = format
	if _format.empty():
		_format = "%s"
	
	text = _format % Globals.price_format(_value, ".", ",")

func update_value(_value):
	value = _value
	print_value(value)
