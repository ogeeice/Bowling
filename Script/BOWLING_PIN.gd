extends Spatial


onready var Music = $music/AudioStreamPlayer

func _on_Area_body_entered(body):
	if body.is_in_group("Ball"):
		Music.play()
