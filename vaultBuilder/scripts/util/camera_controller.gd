extends Camera2D

var speed: float = 300
var zoom_percentage: float = 10
var max_zoom: float = 1.5
var max_unzoom: float = 0.4
var zoom_speed: float = 1

var speed_decay := 0.8
var move_dir := Vector2.ZERO


func _physics_process(delta: float) -> void:
	
	var input := Vector2.ZERO

	if Input.is_action_pressed("key_left"):
		input.x -= 1
	if Input.is_action_pressed("key_right"):
		input.x += 1
	if Input.is_action_pressed("key_up"):
		input.y -= 1
	if Input.is_action_pressed("key_down"):
		input.y += 1
	
	move_dir *= speed_decay
	move_dir += input.normalized() * speed * delta

	position += move_dir
	position.x = clamp(position.x, -923, 1230)
	position.y = clamp(position.y, -648, 461)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_to(zoom - Vector2.ONE * zoom_speed)
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_to(zoom + Vector2.ONE * zoom_speed)

func zoom_to(target_zoom: Vector2) -> void:
	target_zoom.x = clamp(target_zoom.x, max_unzoom, max_zoom)
	target_zoom.y = target_zoom.x

	var interpolation_speed: float = 5 
	zoom = zoom.lerp(round(target_zoom), interpolation_speed * get_process_delta_time())
