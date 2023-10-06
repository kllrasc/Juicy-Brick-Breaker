extends StaticBody2D

var decay = 0.01

func _ready():
	pass

func _physics_process(_delta):
	pass

func hit(_ball):
	$ColorRect.color = Color8(201,42,42,255)
	var Wall_sound = get_node_or_null("/root/Game/Wall_Sound")
	if Wall_sound != null:
		Wall_sound.play()
