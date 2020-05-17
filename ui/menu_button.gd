extends TextureButton

export (String) var caption
export (String, "Left", "Center", "Right") var align

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = caption
	var _align = 0
	match (align):
		"Left":
			_align = $Label.ALIGN_LEFT
		"Right":
			_align = $Label.ALIGN_RIGHT
		"Center":
			_align = $Label.ALIGN_CENTER
		_:
			return
	$Label.align = _align


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var color = "727577" if disabled else "5e838c"
	$Label.set("custom_colors/font_color", Color(color))
