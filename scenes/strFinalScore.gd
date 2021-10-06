extends Label
var iShownScore:=0
var iTargetScore:=0
var bDone:=false
func _ready():
	global.connect("game_over",self,'count')
	set_process(true)
	
func _process(delta):
	self.rect_pivot_offset = self.rect_size/2
	self.text=str(int(iShownScore))
	if bDone:
		$animationPlayer.play("done")
		bDone=false
	
func count():
	iTargetScore=global.iScore
	$twn.interpolate_property(self,'iShownScore',iShownScore,iTargetScore,1.0,Tween.TRANS_LINEAR,Tween.EASE_OUT,0.33)
	$twn.start()
	yield($twn,"tween_all_completed")
	$twn.interpolate_property(self,'rect_scale',self.rect_scale,Vector2(2,2),0.33,Tween.TRANS_BACK,Tween.EASE_IN_OUT)
	$twn.start()
	bDone=true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
