extends Control

export var rot_speed = -0.01

onready var Hpop
#onready var muss = $muss/AudioStreamPlayer
onready var target1 = $Control/Control2/PLAY
onready var target2 = $Howtopop/ColorRect/Hback

var mat

func _ready():
	randomize()
	mat = $rot/ball.get_surface_material(0)
	mat.albedo_color = Color(randf(), randf(), randf())
	yield(get_tree().create_timer(0.7),"timeout")
	target1.grab_focus()
#	muss.play()

func _input(event):
	if Input.is_action_just_released("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func _process(delta):
	Hpop = get_node("Howtopop")
	$rot.rotate_z(rot_speed)
	$Post.rotate_y(rot_speed)

func _on_EXIT_pressed():
	get_tree().quit()


func _on_HOW_TO_PLAY_pressed():
	Hpop.show()
	$Control.hide()
	target2.grab_focus()

func _on_Hback_pressed():
	Hpop.hide()
	$Control.show()
	target1.grab_focus()


func _on_PLAY_pressed():
	get_tree().change_scene('res://Scenes/Level_Select.tscn')
