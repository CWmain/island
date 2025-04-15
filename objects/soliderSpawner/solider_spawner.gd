extends Node2D
class_name Spawner

@export var solider: PackedScene
@export var toSpawn: int
@export var spawnGap: float
@export var spawnColor: Solider.soliderColor = -1

@export var trailMap: TileMapLayer

var manager: SoliderManager = null
var spawnCount: int = 0
var timer: float = 0.0
var newColor: int = 0

signal createdSolider(color: Solider.soliderColor)

func _physics_process(delta: float) -> void:
	timer += delta
	if spawnCount < toSpawn and timer >= spawnGap:
		timer -= spawnGap
		var s:Solider = solider.instantiate()
		s.changedColor.connect(manager._on_solider_color_change)
		s.trailMap = trailMap
		
		get_tree().get_root().add_child(s)
		s.linear_velocity = Vector2((randf()*2)-1,(randf()*2)-1)
		s.position = position
		if spawnColor == -1:
			s.myColor = newColor as Solider.soliderColor
			manager.count[newColor as Solider.soliderColor] += 1
			newColor += 1
			if newColor > 2:
				newColor = 0
		else:
			s.myColor = spawnColor
			createdSolider.emit(spawnColor)
		s.updateColor()
		
		spawnCount += 1

func orderSoliders(numberToSpawn: int) -> void:
	toSpawn = numberToSpawn
	spawnCount = 0
