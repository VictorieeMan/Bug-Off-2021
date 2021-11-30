extends Node

export (PackedScene) var mob_scorpionfly

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	randomize()
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_player_Area2D_hit():
	pass # Replace with function body.

func game_over():
	$mobTimer.stop()
	get_tree().change_scene("res://menu.tscn")
	
func new_game():
	$player_Area2D.start($startPosition.position)
	$startTimer.start()

func _on_startTimer_timeout():
	$mobTimer.start()


func _on_mobTimer_timeout():
	#Random spawn position on path
	$mobPath/mobSpawnLocation.offset = randi()
	#Creating a mob instance
	var mob = mob_scorpionfly.instance()
	add_child(mob)
	#Seting direction of mob
	var direction = $mobPath/mobSpawnLocation.rotation + PI / 2
	#Set a random start location
	mob.position = $mobPath/mobSpawnLocation.position
	#Add some randomness to the direction
	direction += rand_range(-PI/4 , PI/4)
	mob.rotation=direction
	#Set the velocity (Speed and direction vector)
	var speed_scalar = 2
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed)*speed_scalar, 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_AudioStreamPlayer_finished():
	get_tree().change_scene("res://endCredits.tscn")
