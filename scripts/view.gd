extends Node3D

@export_group("Properties")
@export var target: Node

@export_group("Zoom")
@export var zoom_minimum = 16
@export var zoom_maximum = 0
@export var zoom_speed = 20

@export_group("Rotation")
@export var rotation_speed = 240

var camera_rotation:Vector3
var zoom = 10
var dragging := false
@onready var camera = $Camera
var MOUSE_BUTTON_LEFT := 1
var MOUSE_BUTTON_WHEEL_UP := 4
var MOUSE_BUTTON_WHEEL_DOWN := 5


func _ready():
	
	camera_rotation = rotation_degrees # Initial rotation
	
	pass

func _physics_process(delta):
	
	# Set position and rotation to targets
	
	self.position = self.position.lerp(target.position, delta * 4)
	rotation_degrees = rotation_degrees.lerp(camera_rotation, delta * 6)
	
	camera.position = camera.position.lerp(Vector3(0, 0, zoom), 8 * delta)
	
	handle_input(delta)

# Handle input
func _input(event):
	# เริ่มหรือหยุดลากเมาส์ด้วย action "mouse_motion"
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		#print("Dragging:", dragging, " Mouse moved:", event.relative)
	# ถ้าลากเมาส์อยู่ และมีการเคลื่อนไหวของเมาส์
	elif event is InputEventMouseMotion and dragging:
		var mouse_delta = event.relative
		camera_rotation.y -= mouse_delta.x * rotation_speed * 0.001
		camera_rotation.x -= mouse_delta.y * rotation_speed * 0.001
		camera_rotation.x = clamp(camera_rotation.x, -80, 80)
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom -= zoom_speed * get_process_delta_time()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom += zoom_speed * get_process_delta_time()
		zoom = clamp(zoom, zoom_maximum, zoom_minimum)

func handle_input(delta):

	# Rotation
	
	var input := Vector3.ZERO
	
	input.y = Input.get_axis("camera_left", "camera_right")
	input.x = Input.get_axis("camera_up", "camera_down")
	
	camera_rotation += input.limit_length(1.0) * rotation_speed * delta
	camera_rotation.x = clamp(camera_rotation.x, -80, 80)
	
	# Zooming
	
	zoom += Input.get_axis("zoom_in", "zoom_out") * zoom_speed * delta
	zoom = clamp(zoom, zoom_maximum, zoom_minimum)
