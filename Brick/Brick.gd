extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

func _ready():
	randomize()
	position = new_position

func _physics_process(_delta):
	if dying:
		queue_free()

func hit(_ball):
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(), 1)
	$ColorRect.color = Color8(201,42,42,255)
	var Brick_sound = get_node_or_null("/root/Game/Brick_Sound")
	if Brick_sound != null:
		Brick_sound.play()
	

func die():
	dying = true
	collision_layer = 0
	$ColorRect.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instantiate()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
			
