extends Node3D
var rng=RandomNumberGenerator.new()
var animSpeedRNG=rng.randf_range(0.6, 1.4)
var enemyID #enemyID allows for slightly easier identification/reference of enemies
var hp=5 #fallback stats
var tp=1
var atk=1
var def=0
func _ready() -> void:
	$mareAnims.play("idle",-1,animSpeedRNG)
	enemyID = str(get_node(".")).get_slice(":",0)
	match enemyID: #grab stats
		"maremare":
			hp=23
			tp=10
			atk=2
			def=0

func enemyAction():
	var selectedAttackValue=RandomNumberGenerator.new().randi_range(0,2)
	match enemyID:
		"maremare":
			match selectedAttackValue:
				0:
					commonAction("loafAround")
				1:
					return commonAction("basicAttack")
				2:
					$"../../../battleUI/window".queueText(enemyID+" charges at you! \n")
					return roundi(atk * 1.5)

func commonAction(action):
	match action:
		"loafAround":
			$"../standardEnemyAnims".play("action")
			$"../../../battleUI/window".queueText(enemyID+" is loafing around.\n")
		"basicAttack":
			$"../../../battleUI/window".queueText(enemyID+" attacks!\n")
			return atk
