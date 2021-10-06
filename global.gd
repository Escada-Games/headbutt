extends Node
var iScore:=0 setget setScore
const cWhite=Color('#E0E0E2')
const fGRAVITY:=10
signal scorePlus
signal game_over
signal game_start

func _ready():
	self.pause_mode=Node.PAUSE_MODE_PROCESS
	pass # Replace with function body.
	
func setScore(value):
	iScore=value
	emit_signal("scorePlus")

func framePause():
	get_tree().paused=true
	yield(get_tree().create_timer(0.01),"timeout")
	get_tree().paused=false
	pass

func gameOver()->void:
	emit_signal('game_over')
	pass

func gameStart()->void:
	emit_signal("game_start")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
