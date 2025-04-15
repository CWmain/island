extends Node
class_name SoliderManager

# Will be in charge of keeping track of all spawners / soliders
# It will request the spawners to spawn batches of soliders at different times
# based off of a graph 
@export var spawners: Dictionary[Solider.soliderColor, Spawner]

var count: Dictionary[Solider.soliderColor, int]

func _ready() -> void:
	count[Solider.soliderColor.RED] = 0
	count[Solider.soliderColor.BLUE] = 0
	count[Solider.soliderColor.GREEN] = 0
	
	spawners[Solider.soliderColor.RED].orderSoliders(20)
	spawners[Solider.soliderColor.BLUE].orderSoliders(10)
	spawners[Solider.soliderColor.GREEN].orderSoliders(30)
