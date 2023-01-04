extends KinematicBody

var gravity = 0.98
var velocity = Vector3()
var camera_x_rotation = 0

export var SPEED = 20
export var ACCEL = 20
export var MOUSE_SENSITIVITY = 0.3


onready var head = $Head
onready var camera = $Head/Camera

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * MOUSE_SENSITIVITY))
#head rotates on x axis left and right
		var x_delta = event.relative.y * MOUSE_SENSITIVITY
		#rotates the camera on the y axis up and down
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			#if camera rot within -90 and +90 then rotate
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta


func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	#movement of head via transformation pointer
	
	var direction = Vector3()
	if Input.is_action_pressed("forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("backward"):
		direction += head_basis.z
	
	if Input.is_action_pressed("left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("right"):
		direction += head_basis.x
	
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * SPEED, ACCEL * delta)
	velocity.y -= gravity
	velocity = move_and_slide(velocity,Vector3.UP)
