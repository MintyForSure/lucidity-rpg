extends Control

func _ready() -> void:
	$text.set_visible(true)
	$animationPlayer.play("auto")

func _process(_delta: float) -> void:
	await $animationPlayer.animation_finished
	queue_free()
