extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	global.connect("game_start",self,'gameStart')
	$twn.connect("tween_all_completed",self,'queue_free')
func gameStart():
	$twn.interpolate_property(self,'modulate:a',1,0,0.33,Tween.TRANS_QUAD,Tween.EASE_IN)
	$twn.start()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
