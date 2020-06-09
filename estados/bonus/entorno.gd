extends Spatial

signal prize_selected

var selected = false

onready var camera = get_node("Escena-Banco-02")
onready var raycast = get_node("Escena-Banco-02/RayCast")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if raycast.is_colliding() and !selected:
		selected = true
		emit_signal("prize_selected", raycast.get_collider().name)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			raycast.enabled = true
			raycast.cast_to = camera.project_ray_normal(event.position) * 10
		else:
			raycast.enabled = false
			selected = false
