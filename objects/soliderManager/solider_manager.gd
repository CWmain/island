extends Node
class_name SoliderManager

# Will be in charge of keeping track of all spawners / soliders
# It will request the spawners to spawn batches of soliders at different times
# based off of a graph 

## List of spawners
@export var spawners: Dictionary[Solider.soliderColor, Spawner]


var soliderTotal: int = 0
var count: Dictionary[Solider.soliderColor, int]
var timer: float = 0

# Refactor a better system to determin spawns
# I would like to have it so when a certain time is reached,
# that amount of spawns of that color is done
var a: bool = false
var b: bool = false
var c: bool = false

signal updateCount

func _ready() -> void:
	count[Solider.soliderColor.RED] = 0
	count[Solider.soliderColor.BLUE] = 0
	count[Solider.soliderColor.GREEN] = 0
	
	for spawnerType in spawners:
		spawners[spawnerType].manager = self
		spawners[spawnerType].createdSolider.connect(_on_created_solider)
	
	
	
	
	
func _process(delta: float) -> void:
	timer += delta
	if timer > 0 and !a:
		a = true
		spawners[Solider.soliderColor.RED].orderSoliders(20)
	if timer > 5 and !b:
		b = true
		spawners[Solider.soliderColor.BLUE].orderSoliders(100)
	if timer > 7 and !c:
		c = true
		spawners[Solider.soliderColor.GREEN].orderSoliders(30)
		

func _on_created_solider(color: Solider.soliderColor):
	count[color] += 1
	soliderTotal += 1
	updateCount.emit()
	
func _on_solider_color_change(oldColor: Solider.soliderColor, newColor: Solider.soliderColor):
	count[oldColor] -= 1
	count[newColor] += 1
	updateCount.emit()
