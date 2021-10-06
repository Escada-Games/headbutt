extends Node2D
var fRadius:=0.0
func _ready()->void:
	$twn.interpolate_property(self,'fRadius',0.0,32.0,0.4,Tween.TRANS_QUINT,Tween.EASE_OUT)
	$twn.interpolate_property(self,'modulate:a',1,0,0.4,Tween.TRANS_QUAD,Tween.EASE_IN,0.1)
	$twn.start()
	$twn.connect("tween_all_completed",self,'queue_free')
	set_process(true)
func _process(_delta)->void:update()
func _draw()->void:
	draw_arc(Vector2(),fRadius,0,2*PI,360,Color.white,2,true)
	draw_arc(Vector2(),0.8*fRadius,0,2*PI,360,Color.white,2,true)
