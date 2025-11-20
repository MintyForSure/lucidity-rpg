extends NinePatchRect

var isCentered=false
var textQueue=[]
var continueOK=false
var returnOK=false
var textState="busy"

func _process(delta: float) -> void:
	#print(continueOK)
	#if Input.is_action_just_pressed("ui_cancel"):
		#queueText("lol")
		#queueText("lol2")
		#print(textQueue)
	continueOK=true
	if Input.is_action_just_pressed("ui_accept") and continueOK==true:
		%continueSFX.play()
		if len(textQueue) >= 0:
			textState="busy"
			textQueue.remove_at(0)


func windowInit(length,width,centered=null) -> void:
	set_size(Vector2(length,width))
	$continueIcon.set_visible(false)
	$continueIcon.play()
	$text.set_visible_ratio(0)
	if centered==true:
		isCentered=true #sets this window to have centered text
func queueText(text,whereTo=null):
	textQueue.append(text)
	textWindow(whereTo) #pass "whereTo" into this function (a bit easier)
func textWindow(whereTo=null): 
	match textState:
		"busy":
			$continueIcon.set_visible(false)
			continueOK=false
			$text.set_text(str(textQueue[0]))
			$animationPlayer.play("tween")
			await $animationPlayer.animation_finished
			if whereTo=="actionPick":
				$%commandAnims.play("appear")
				$"..".uiState="actionPick"
			else:
				textState="free"
		"free":
			$continueIcon.set_visible(true)
			if whereTo=="actionPick":
				$%commandAnims.play("appear")
				$"..".uiState="actionPick"
func nextInQueue()->void:
	textWindow()
func flushText():
	textQueue=[]
	$continueIcon.set_visible(false)
	$text.set_text("")
