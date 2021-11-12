extends Node2D


# Declare member variables here. Examples:
var messages = [
	"Man of earthly mind!",
	"Do you belive in me?"
]

var typing_speed = .1
var read_time = 2

var current_message = 0
var display = ""
var current_char = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	start_dialogue()

func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func stop_dialogue():
	$AudioStreamPlayer2D.stop()
	#get_parent().remove_child(self)
	#queue_free()
	pass

func _on_next_char_timeout():
	if(current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		$Label.text = display
		current_char +=1
	else:
		$next_char.stop()
		$AudioStreamPlayer2D.stop()
		$next_message.set_wait_time(read_time)
		$next_message.start()

func _on_next_message_timeout():
	if(current_message == len(messages) - 1):
		stop_dialogue()
	else:
		current_message += 1
		display = ""
		current_char = 0
		$AudioStreamPlayer2D.play()
		$next_char.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Special thanks to erdavids for sharing educational script on youtube and github gists
#https://gist.github.com/erdavids/db39bd67dc420ed41ad385334154bc25
#https://www.youtube.com/watch?v=Cp9g2GY7aTg
