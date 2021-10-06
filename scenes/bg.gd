extends Node2D
const vVELOCITY:=Vector2(1,1)*16
func _ready()->void:set_process(true)
func _process(delta)->void:
	self.global_position+=vVELOCITY*delta
	if self.global_position.x>48:
		self.global_position=Vector2()
	pass
