extends Area2D

func _ready()->void:pass
func _on_areaOobDetector_body_entered(body:PhysicsBody2D)->void:
	if body.is_in_group('Ball'):
		global.gameOver()
