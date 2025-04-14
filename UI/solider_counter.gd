extends Label

var count: Dictionary[Solider.soliderColor, int]
@onready var red: ProgressBar = $Red
@onready var green: ProgressBar = $Green
@onready var blue: ProgressBar = $Blue

@export var maxSoliders: float = 300.0

func _ready() -> void:
	count[Solider.soliderColor.RED] = 0
	count[Solider.soliderColor.BLUE] = 0
	count[Solider.soliderColor.GREEN] = 0
	updateLabel()

func _on_solider_color_change(oldColor: Solider.soliderColor, newColor: Solider.soliderColor):
	count[oldColor] -= 1
	count[newColor] += 1
	updateLabel()

func updateLabel()->void:
	red.value = count[Solider.soliderColor.RED]/maxSoliders
	green.value = count[Solider.soliderColor.GREEN]/maxSoliders
	blue.value = count[Solider.soliderColor.BLUE]/maxSoliders
	var total: int = count[Solider.soliderColor.RED] + count[Solider.soliderColor.BLUE] + count[Solider.soliderColor.GREEN]
	text = "TOTAL: %d\nRED: %d\nBLUE: %d\nGREEN: %d" % [total, count[Solider.soliderColor.RED], count[Solider.soliderColor.BLUE], count[Solider.soliderColor.GREEN]]
