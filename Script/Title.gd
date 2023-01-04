extends Control


func _ready():
	$Control/AnimatedSprite.play("Logo")



func _on_AnimatedSprite_animation_finished():
	get_tree().change_scene('res://Scenes/Title_Screen.tscn')
