extends KinematicBody2D

var vVelocity:=Vector2()
var bWasOnFloor:=false

var iJumpBuffer:=0
const iMAXJUMPBUFFER:=5
var iCoyoteTime:=0
const iMAXCOYOTETIME:=5

const fSPEED:=182
const fGRAVITY:=global.fGRAVITY#10
const fJUMPFORCE:=166

const scnLandParticles:=preload("res://scenes/particlesLand.tscn")
const fxCircle:=preload("res://scenes/fxCircle.tscn")
const sfxHit:=preload("res://scenes/sfxHit.tscn")
const sfxLand:=preload("res://scenes/sfxLand.tscn")
const sfxJump:=preload("res://scenes/sfxJump.tscn")

func _ready()->void:
	set_physics_process(true)
	pass
	
func _physics_process(delta)->void:
	if Input.is_action_just_pressed("ui_reset"):
		global.iScore=0
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed('ui_home') and OS.is_debug_build():
		global.iScore+=100
	iJumpBuffer-=1
	iCoyoteTime-=1
	
	var vMotion:=Vector2()
	vMotion.x = -1 if Input.is_action_pressed('ui_left') else 1 if Input.is_action_pressed('ui_right') else 0
	vMotion.y = -1 if Input.is_action_pressed('ui_up') else 1 if Input.is_action_pressed('ui_down') else 0
	if Input.is_action_just_pressed('ui_jump'):iJumpBuffer=iMAXJUMPBUFFER
	if self.is_on_floor():iCoyoteTime=iMAXCOYOTETIME
	
	$sprite.rotation=lerp($sprite.rotation,deg2rad(10)*vMotion.x,0.1)
	
	vVelocity.y+=fGRAVITY
	vVelocity.x=lerp(vVelocity.x,vMotion.x*fSPEED,0.15)
	
	if iJumpBuffer>0 and iCoyoteTime>0:
		iJumpBuffer=0
		iCoyoteTime=0
		self.vVelocity.y=-fJUMPFORCE
		$twn.interpolate_property($sprite,'scale',16*Vector2(0.6,1.4),Vector2(16,16),0.3,Tween.TRANS_BACK)
		$twn.start()
		var i = sfxJump.instance()
		get_parent().add_child(i)
		pass
	
	move_and_slide(vVelocity,Vector2(0,-1))
	
	if self.is_on_floor() and not bWasOnFloor:
		var i = scnLandParticles.instance()
		i.global_position = self.global_position+Vector2(0,8)
		i.emitting=true
		get_parent().add_child(i)
		var j = sfxLand.instance()
		get_parent().add_child(j)
		
	bWasOnFloor=self.is_on_floor()


func _on_areaHead_body_entered(body:PhysicsBody2D):
	if body.is_in_group("Ball"):
		if self.vVelocity.y<0:
			if body.bStarted==false:
				body.start()
				global.iScore+=1
				global.framePause()
				global.gameStart()
				
				var vDirection:=Vector2(rand_range(-0.6,0.6),-rand_range(0.8,1.2))
				body.vVelocity.x=182*vDirection.normalized().x
				body.vVelocity.y=182*vDirection.normalized().y
				
				var i = fxCircle.instance()
				i.global_position=body.global_position
				get_parent().add_child(i)
				var j = sfxHit.instance()
				get_parent().add_child(j)
			else:
				global.iScore+=1
				global.framePause()
				global.gameStart()
				
				body.vVelocity.x=1.2*self.vVelocity.x*(1+rand_range(-0.2,0.2))
				body.vVelocity.y=1.2*self.vVelocity.y*(1+rand_range(0,0.15))
				
				var i = fxCircle.instance()
				i.global_position=body.global_position
				get_parent().add_child(i)
				var j = sfxHit.instance()
				get_parent().add_child(j)
	
	pass # Replace with function body.
