extends Control

func _ready():
	self.modulate.a=0
	self.visible=true
	global.connect("game_over",self,"gameOver")
func gameOver():
	$twn.interpolate_property(self,'modulate:a',0,1,0.3,Tween.TRANS_QUAD,Tween.EASE_IN)
	$twn.start()
