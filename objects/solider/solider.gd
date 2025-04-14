extends RigidBody2D
class_name Solider

enum soliderColor{
	RED,
	BLUE,
	GREEN
}

@export var speed: float = 100
@export var myColor: soliderColor = 0 as soliderColor

@onready var label: Label = $Label
@onready var color_rect: ColorRect = $ColorRect

signal changedColor(oldColor: soliderColor, newColor: soliderColor)

func _ready() -> void:
	updateColor()

func _physics_process(delta: float) -> void:
	# Normalise the speed of all soliders
	linear_velocity = linear_velocity.normalized()*speed
	label.text = str(linear_velocity.length())

func updateColor()->void:
	if myColor == soliderColor.RED:
		color_rect.color = Color.RED
	if myColor == soliderColor.GREEN:
		color_rect.color = Color.GREEN
	if myColor == soliderColor.BLUE:
		color_rect.color = Color.BLUE

func _on_body_entered(body: Node) -> void:
	if body is not Solider:
		return
	var newColor: soliderColor = resolveWinner(myColor, body.myColor)
	changedColor.emit(myColor, newColor)
	myColor = newColor
	updateColor()
 
func resolveWinner(color1: int, color2: int)->soliderColor:
	if color1 == color2:
		return color1
		
	if (color1 == soliderColor.RED and color2 == soliderColor.GREEN) or (color2 == soliderColor.RED and color1 == soliderColor.GREEN):
		return soliderColor.RED
		
	if (color1 == soliderColor.GREEN and color2 == soliderColor.BLUE) or (color2 == soliderColor.GREEN and color1 == soliderColor.BLUE):
		return soliderColor.GREEN
		
	if (color1 == soliderColor.BLUE and color2 == soliderColor.RED) or (color2 == soliderColor.BLUE and color1 == soliderColor.RED):
		return soliderColor.BLUE
	
	printerr("No matching colors???")
	return -1
		
	
