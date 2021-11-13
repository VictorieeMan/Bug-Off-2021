extends Node


# Declare member variables here. Examples:


# Called when the node enters the scene tree for the first time.
func _ready():
	var dialog = Dialogic.start("theVoid")
	add_child(dialog)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_intro_length_timeout():
	get_tree().change_scene("res://level_1.tscn")
