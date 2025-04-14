extends Area2D

@onready var color_rect: ColorRect = $ColorRect

@export var zoneColor: Solider.soliderColor = 0 as Solider.soliderColor:
	set(value):
		zoneColor = value
		updateColorRect()

func _ready()->void:
	updateColorRect()
	
func _input(event: InputEvent) -> void:
	if event.is_action("CycleDown"):
		zoneColor = zoneColor-1 if zoneColor-1 >= 0 else 2
		updateColorRect()
	if event.is_action("CycleUp"):
		zoneColor = zoneColor+1 if zoneColor+1 < 3 else 0
		updateColorRect()

func _physics_process(delta: float) -> void:
	position = get_global_mouse_position()

func updateColorRect()->void:
	match zoneColor:
			Solider.soliderColor.RED:
				color_rect.color = Color.RED
			Solider.soliderColor.GREEN:
				color_rect.color = Color.GREEN
			Solider.soliderColor.BLUE:
				color_rect.color = Color.BLUE

func _on_body_entered(body: Node2D) -> void:
	if body is not Solider:
		return
	var s: Solider = body
	s.changedColor.emit(s.myColor, zoneColor)
	s.myColor = zoneColor
	body.updateColor()
