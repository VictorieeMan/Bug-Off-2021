extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400	#Player movement speed pixels/sec
var screen_size			#Size of game window


# Called when the node enters the scene tree for the first time.
func _ready():
	#hide() #Keeps player hidden in the ready phase
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Taking userinput and translates it into player movement
	var velocity = Vector2() #Movement vector of the player
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	#Preventing the player to leave the screen
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
