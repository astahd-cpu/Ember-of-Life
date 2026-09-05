extends CharacterBody2D

@export var speed: float = 100.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"

func _physics_process(_delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("A"):
		direction.x -= 1
	if Input.is_action_pressed("D"):
		direction.x += 1
	if Input.is_action_pressed("W"):
		direction.y -= 1
	if Input.is_action_pressed("S"):
		direction.y += 1
	
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed
		play_walk_animation(direction)
	else:
		velocity = Vector2.ZERO
		play_idle_animation()
	
	move_and_slide()

func play_walk_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("walk_right")
			animated_sprite.flip_h = false  # Обычное отображение для правого направления
			last_direction = "right"
		else:
			animated_sprite.play("walk_right")  # Используем ту же анимацию
			animated_sprite.flip_h = true  # Отражаем горизонтально для левого направления
			last_direction = "left"
	else:
		if direction.y > 0:
			animated_sprite.play("walk_down")
			animated_sprite.flip_h = false
			last_direction = "down"
		else:
			animated_sprite.play("walk_up")
			animated_sprite.flip_h = false
			last_direction = "up"

func play_idle_animation():
	match last_direction:
		"down":
			animated_sprite.play("idle_down")
			animated_sprite.flip_h = false
		"up":
			animated_sprite.play("idle_up")
			animated_sprite.flip_h = false
		"left":
			animated_sprite.play("idle_right")  # Используем правую анимацию для покоя
			animated_sprite.flip_h = true  # Отражаем для левого направления
		"right":
			animated_sprite.play("idle_right")
			animated_sprite.flip_h = false
