extends NinePatchRect

var isCentered=false
var textQueue=[]
var continueOK=false
var returnOK=false

func _process(delta: float) -> void:
	#print(continueOK)
	#if Input.is_action_just_pressed("ui_cancel"):
		#queueText("lol")
		#queueText("lol2")
		#print(textQueue)
	continueOK=true
	$continueIcon.set_visible(true)
	if Input.is_action_just_pressed("ui_accept") and continueOK==true:
		%continueSFX.play()
		if len(textQueue) >= 0:
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
	$continueIcon.set_visible(false)
	continueOK=false
	$text.set_text(str(textQueue[0]))
	$animationPlayer.play("tween")
	await $animationPlayer.animation_finished
	if whereTo=="actionPick":
		$%commandAnims.play("appear")
		$"..".uiState="actionPick"
	#if len(textQueue) > 0:
		#textQueue.remove_at(0)
		#textWindow()
	return whereTo #pass "whereTo" around like that one friend at the party.
func nextInQueue()->void:
	textWindow()
func flushText():
	textQueue=[]
	$continueIcon.set_visible(false)
	$text.set_text("")
