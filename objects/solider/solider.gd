extends RigidBody2D
class_name Solider

enum soliderColor{
	RED,
	BLUE,
	GREEN
}

@export var speed: float = 100
@export var myColor: soliderColor = 0 as soliderColor
var isImmune: bool = true

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
 
func resolveWinner(currentColor: int, otherColor: int)->soliderColor:
	if isImmune:
		return currentColor
		
	if currentColor == otherColor:
		return currentColor
		
	if (currentColor == soliderColor.RED and otherColor == soliderColor.GREEN) or (otherColor == soliderColor.RED and currentColor == soliderColor.GREEN):
		return soliderColor.RED
		
	if (currentColor == soliderColor.GREEN and otherColor == soliderColor.BLUE) or (otherColor == soliderColor.GREEN and currentColor == soliderColor.BLUE):
		return soliderColor.GREEN
		
	if (currentColor == soliderColor.BLUE and otherColor == soliderColor.RED) or (otherColor == soliderColor.BLUE and currentColor == soliderColor.RED):
		return soliderColor.BLUE
	
	printerr("No matching colors???")
	return -1
