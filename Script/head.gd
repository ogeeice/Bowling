extends Spatial


# look stats
export var lookSensitivity =15.0
export var minLookAngle =-60.0
export var maxLookAngle =60.0
# vectors
var mouseDelta = Vector2()
# components

onready var head = $"."

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# called when an input is detected
func _input(event):
	# set "mouseDelta" when we move our mouse
	if event is InputEventMouseMotion:
		mouseDelta=event.relative

# called every frame
func _process(delta):
	# get the rotation to apply to the camera and player
	var rot = Vector3 (mouseDelta.y,mouseDelta.x,0)* lookSensitivity * delta
	# camera vertical rotation
	rotation_degrees.x+= rot.x
	rotation_degrees.x= clamp (rotation_degrees.x,minLookAngle,maxLookAngle)
	# player horizontal rotation
	head.rotation_degrees.y-=rot.y
	# clear the mouse movement 
	mouseDelta = Vector2()
