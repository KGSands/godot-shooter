extends Area2D

var rotation_speed = 2
var available_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health']
var type = available_options[randi()%len(available_options)]

var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color.AQUA
	elif type == 'grenade':
		$Sprite2D.modulate = Color.LIGHT_GREEN
	else:
		$Sprite2D.modulate = Color.LIGHT_CORAL
		
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, 'position', target_pos, 0.5)
	tween.tween_property(self, 'scale', Vector2(1, 1), 0.3).from(Vector2(0, 0))

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	if type == 'laser':
		Globals.laser_amount += 5
	elif type == 'grenade':
		Globals.grenade_amount += 1
	else:
		Globals.health += 10
	queue_free()
