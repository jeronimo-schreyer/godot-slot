extends Spatial

signal prize_selected

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if $RayCast.is_colliding() and !selected:
		selected = true
		emit_signal("prize_selected", $RayCast.get_collider().name)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			var mouse_pos = event.position
			var camera = $"Escena-Banco-02"
			var origin = camera.project_ray_origin(mouse_pos)
			
			$RayCast.enabled = true
			$RayCast.set_translation(Vector3(origin.x, origin.y, origin.z))
			$RayCast.cast_to = camera.project_ray_normal(mouse_pos) * 10
		else:
			$RayCast.enabled = false
