extends Spatial

onready var music = $music/AudioStreamPlayer

var pin_scene = 1
var standing_pins
var can_spawn = false

var score = 0
var bodies

#var immediate_detect
#var Max_pins

var targets
var slow_motion = false
onready var target = $Target

func _ready():
	$CanvasLayer/Holder.hide()
	$CanvasLayer/Holder/Dead.hide()
	yield(get_tree().create_timer(0.7),"timeout")
#	music.play()
	yield(get_tree().create_timer(0.20),"timeout")
	spawner()
	$TargetAnim.play("Target")


func _load_scene(Ballz):
	var tt = load(Ballz).instance()

func _input(event):
	if Input.is_action_just_released("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_released("ui_cancel"):
		get_tree().change_scene('res://Scenes/Level_Select.tscn')
		$".".queue_free()
	
	if Input.is_action_just_pressed("throw"):
		$TargetAnim.stop()


func _process(delta):
#	targets = target.rotation
#	$CanvasLayer/ColorRect/Label.text = str(score)
	
	bodies = $Lane/detect.get_overlapping_bodies()
	
	if bodies.size() == 0:
		can_spawn = false
	else:
		can_spawn = true
	
	if slow_motion == true:
		Engine.time_scale = 0.15
	else:
		Engine.time_scale = 1

func _on_detect_body_entered(body):
	if body.is_in_group("Pins"):
#		if body.size() > 0:
		print("PINS")

# BODY THAT ENTERS BLACK BOX KILLED
func _on_destroyer_body_entered(body):
	slow_motion = false
	can_spawn = true
	body.queue_free()
	$CanvasLayer/Holder/Dead.show()

# SPAWN BALL TO POSITION
func spawner():
	if can_spawn == true:
		var tt = load("res://Scenes/Bowling_Ball.tscn").instance()
		get_node("Lane/Lanepos").add_child(tt)
		_load_scene("res://Scenes/Bowling_Ball.tscn")
		$CanvasLayer/Holder.show()
		$CanvasLayer/Holder/Dead.hide()
		$Kameraa.current = true

func _on_Pin_amount_body_entered(body):
	if body.is_in_group("Pins"):
		print("MAX PIN NUMBER DETECTED")

func _on_Ball_pressed():
	spawner()
	$TargetAnim.play("Target")
	can_spawn = false

func _on_Level_pressed():
	get_tree().change_scene('res://Scenes/Level_Select.tscn')
	$".".queue_free()

func _on_Exit_pressed():
	get_tree().quit()

func _on_slow_body_entered(body):
	if body.is_in_group("Ball"):
		if body.magnitude > 100:
			slow_motion = true
		$Camera.current = true

func _on_slow_body_exited(body):
	if body.is_in_group("Ball"):
		slow_motion = false
