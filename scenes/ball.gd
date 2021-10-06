extends KinematicBody2D

var vVelocity:=Vector2()
var vOldVelocity:=Vector2()

var t:=0
var bStarted:=false
const fGRAVITY:=0.33*global.fGRAVITY
const fxCircle:=preload("res://scenes/fxCircle.tscn")
const sfxHit:=preload("res://scenes/sfxHit.tscn")

func _ready()->void:
	$line2D.set_as_toplevel(true)
	$line2D.clear_points()
	$line2D2.set_as_toplevel(true)
	$line2D2.clear_points()
	add_to_group('Ball')
	set_physics_process(false)
func _physics_process(delta)->void:
	t+=1
	if t%2==0:
		$line2D.add_point($line2D.to_local(self.global_position))
		if $line2D.get_point_count()>128:$line2D.remove_point(0)
		$line2D2.add_point($line2D2.to_local(self.global_position))
		if $line2D2.get_point_count()>128:$line2D2.remove_point(0)
		
	
	#if $raycasts/left.is_colliding() or $raycasts/right.is_colliding():self.vVelocity.x*=-0.7
	self.vVelocity.y+=fGRAVITY
	vVelocity = move_and_slide(vVelocity,Vector2(0,-1))
	
	if abs(vVelocity.x)<1:
		vVelocity.x=-vOldVelocity.x
		if not is_equal_approx(vOldVelocity.x,0):
			global.iScore+=1
			var i = fxCircle.instance()
			i.global_position=self.global_position
			get_parent().add_child(i)
			var j = sfxHit.instance()
			get_parent().add_child(j)
	else:
		vOldVelocity.x=vVelocity.x

func start():
	bStarted=true
	set_physics_process(true)
