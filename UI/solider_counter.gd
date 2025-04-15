extends Label

var count: Dictionary
@onready var red: ProgressBar = $Red
@onready var green: ProgressBar = $Green
@onready var blue: ProgressBar = $Blue

@export var maxSoliders: float = 300.0
@export var soliderManager: SoliderManager = null

func _ready() -> void:
	assert(soliderManager != null)
	count = soliderManager.count
	soliderManager.updateCount.connect(updateLabel)
	updateLabel()

func _on_solider_color_change(oldColor: Solider.soliderColor, newColor: Solider.soliderColor):
	count[oldColor] -= 1
	count[newColor] += 1
	updateLabel()

func updateLabel()->void:
	var total: float = soliderManager.soliderTotal

	if total != 0:
		red.value = count[Solider.soliderColor.RED]/total
		green.value = count[Solider.soliderColor.GREEN]/total
		blue.value = count[Solider.soliderColor.BLUE]/total
	
	text = "TOTAL: %d\nRED: %d\nBLUE: %d\nGREEN: %d" % [total, count[Solider.soliderColor.RED], count[Solider.soliderColor.BLUE], count[Solider.soliderColor.GREEN]]
