extends AudioStreamPlayer
func _ready():
	self.pitch_scale=rand_range(0.9,1.1)
	yield(self,"finished")
	self.queue_free()
