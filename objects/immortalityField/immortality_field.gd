extends Area2D


func _physics_process(_delta: float) -> void:
	position = get_global_mouse_position()

func _on_body_entered(body: Node2D) -> void:
	if body is Solider:
		var s: Solider = body
		s.isImmune = true

func _on_body_exited(body: Node2D) -> void:
	if body is Solider:
		var s: Solider = body
		s.isImmune = false
