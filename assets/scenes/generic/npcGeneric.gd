extends CharacterBody3D
var npcID
@onready var textWindow=$"../characterBody3d/camera3d/subViewportContainer/subViewport/dialogueWindow"
func _ready() -> void:
	npcID = str(get_node(".")).get_slice(":",0)
	JSON.parse_string(FileAccess.get_file_as_string("res://assets/scripts/dialogue.json"))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("confirm") and $area3d.has_overlapping_bodies():
		textWindow.text("you get what you fucking deserve\n","Maremare")
		#%dialogueWindow.text("tl;dr: eat [b][a delicious meal][/b], [b][buddy]\n","Maremare")
