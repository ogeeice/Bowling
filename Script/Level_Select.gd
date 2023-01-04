extends Control

export var ball = -0.01
export var rot_speed = -0.005
var non_rot_speed = 0

var gamescene = null
onready var styles = $Control/Control2/VBoxContainer/STYLE1

func _load_scene(player):
	var xy = load(player).instance()
	xy.set_name("Player")
	gamescene = load("res://Scenes/Game_Scene.tscn").instance()
	gamescene.get_node("Spawn_Point").add_child(xy)
	get_parent().add_child(gamescene)
	hide()

func _on_STYLE1_pressed():
	_load_scene("res://Scenes/pin_formation/style1.tscn")

func _on_STYLE2_pressed():
	_load_scene("res://Scenes/pin_formation/style2.tscn")

func _on_STYLE3_pressed():
	_load_scene("res://Scenes/pin_formation/style3.tscn")

func _on_STYLE4_pressed():
	_load_scene("res://Scenes/pin_formation/style4.tscn")

func _on_BACK_pressed():
	get_tree().change_scene('res://Scenes/Title_Screen.tscn')
