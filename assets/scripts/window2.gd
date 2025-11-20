extends Control

var continueOK=false
var queue=[]

func _ready() -> void:
	#$animationPlayer.play("RESET")
	pass
func text(body,speaker=null):
	print("hi")
	if speaker!=null:
		$ninePatchRect/ninePatchRect/speaker.set_text(str(speaker))
	$ninePatchRect/mainText.set_text(body)
	$animationPlayer.play("text")
	await $animationPlayer.animation_finished
	print("ok")
