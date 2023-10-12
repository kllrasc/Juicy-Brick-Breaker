extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1
var tween

func _ready():
	randomize()
	position.x = new_position.x
	position.y = -100
	tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.5 + randf()*2).set_trans(Tween.TRANS_BOUNCE)

func _physics_process(_delta):
	if dying and not $Confetti.emitting and not tween:
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
	
