extends NinePatchRect

var windowState="busy"
var textQueue=[]
signal continueText

func windowInit(length,width,centered=null,quickWindow=null):
	set_size(Vector2(length,width))
	$continueIcon.set_visible(false)
	$continueIcon.play()
	$text.set_visible_ratio(1)
	#$text.set_text("* i like girls kissing <3 \n")
	if centered==true:
		$text.set_horizontal_alignment(1)
		$text.set_vertical_alignment(1)
	if quickWindow==true:
		$continueIcon.set_visible(false)
func textWindow(text,whereTo=null,quickWindow=null,centered=null):
	if quickWindow==true:
		$text.set_text(text)
		windowState="free"
	if centered==true:
		$text.set_text("[center]"+text+"[/center]")
	match windowState:
		"busy":
			$continueIcon.set_visible(false)
			$text.set_text(text)
			$text/appearingText.play("start")
			await $text/appearingText.animation_finished
			windowState="free"
		"free":
			#print(windowState)
			$continueIcon.set_visible(true)
			if Input.is_action_just_pressed("ui_select"):
				#continueText.emit()
				$%continueSFX.play()
				flushText()
			if whereTo=="actionPick":
				$%commandAnims.play("appear")
				$"..".uiState="actionPick"
func flushText():
	$continueIcon.set_visible(false)
	$text.set_text("")
	print("#flushed")
func queueText(text):
	$continueIcon.set_visible(false)
	#textQueue.append(text)
	#print(textQueue)
	$text.append_text(text)
	$text/appearingText.play("start")
	await $text/appearingText.animation_finished
	$continueIcon.set_visible(true)
