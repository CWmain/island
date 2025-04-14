extends Node2D

@export var solider: PackedScene
@export var toSpawn: int
@export var spawnGap: float
@export var spawnColor: Solider.soliderColor = -1
@export var solider_counter: Label
var spawnCount: int = 0
var timer: float = 0.0
var newColor: int = 0

func _physics_process(delta: float) -> void:
	timer += delta
	if spawnCount < toSpawn and timer >= spawnGap:
		timer -= spawnGap
		var s:Solider = solider.instantiate()
		s.changedColor.connect(solider_counter._on_solider_color_change)
		
		get_tree().get_root().add_child(s)
		s.linear_velocity = Vector2((randf()*2)-1,(randf()*2)-1)
		s.position = position
		if spawnColor == -1:
			s.myColor = newColor as Solider.soliderColor
			solider_counter.count[newColor as Solider.soliderColor] += 1
			newColor += 1
			if newColor > 2:
				newColor = 0
		else:
			s.myColor = spawnColor
			solider_counter.count[spawnColor] += 1
		s.updateColor()
		
		spawnCount += 1
	
