extends Label
func _ready()->void:
	self.text='0'
	global.connect("scorePlus",self,'updateScore')
	set_process(true)
func _process(_delta)->void:
	self.rect_pivot_offset = self.rect_size/2
	self.rect_scale.x=lerp(self.rect_scale.x,1,0.1)
	self.rect_scale.y=lerp(self.rect_scale.y,1,0.1)
	self.rect_rotation=lerp(self.rect_rotation,0,0.1)
	
func updateScore():
	self.rect_scale=Vector2(1,1)*5
	self.rect_rotation=rand_range(-60,60)
	self.text=str(global.iScore)
