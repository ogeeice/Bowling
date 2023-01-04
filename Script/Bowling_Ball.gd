extends RigidBody

onready var song = $song/AudioStreamPlayer

var magnitude = 0
export var max_magnitude = 300 #150
export var move_speed = 0.5

var material

var can_move = true
var can_throw = true
var direction = Vector3()
onready var target : Node = get_node("/root/Game_Scene/Target")

func _ready():
	randomize()
	material = $bowlingball.get_surface_material(0)
	material.albedo_color = Color(randf(), randf(), randf())

func _process(delta):
	$CanvasLayer/Control/force.value = magnitude
	if magnitude > max_magnitude:
		magnitude = 300
	
	if Input.is_action_pressed("throw"):
		magnitude += 5
	print(magnitude)

func _integrate_forces(state):
	if Input.is_action_pressed("right") and can_move == true:
		apply_impulse(self.global_transform.origin,Vector3.RIGHT * move_speed)
	elif Input.is_action_pressed("left") and can_move == true:
		apply_impulse(self.global_transform.origin,Vector3.LEFT * move_speed)
	
	if Input.is_action_just_released("throw") and can_throw == true:
		can_move = false
		self.mode = RigidBody.MODE_RIGID
		self.global_transform = target.global_transform
		self.scale = Vector3.ONE
		apply_impulse(self.global_transform.origin,Vector3(-target.rotation.y,0,-1) * magnitude)
#		$Dust.emitting = true
		song.play()
		$CanvasLayer/Control/force.hide()
		can_throw = false
