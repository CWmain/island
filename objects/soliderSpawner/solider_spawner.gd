extends Node2D

@export var solider: PackedScene
@export var toSpawn: int
@export var spawnGap: float

var spawnCount: int = 0
var timer: float = 0.0
var newColor: int = 0

func _physics_process(delta: float) -> void:
	timer += delta
	if spawnCount < toSpawn and timer >= spawnGap:
		timer -= spawnGap
		var s:Solider = solider.instantiate()
		get_tree().get_root().add_child(s)
		s.position = Vector2(100,100)
		s.linear_velocity = Vector2(randf(),randf())
		
		s.myColor = newColor
		s.updateColor()
		newColor += 1
		if newColor > 2:
			newColor = 0
		spawnCount += 1
	
