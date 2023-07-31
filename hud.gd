extends CanvasLayer

signal on_pressed_start

var config = ConfigFile.new()
var name_file = "user://highscore.save"
var save_score = 0

func _ready():
	update_score()
	
func update_score():
	var err = config.load(name_file)
	if err == OK:
		save_score = config.get_value("Score", "highest_score")
	else:
		save_score = 0
		
	$VBoxContainer/PanelContainer3/VBoxContainer/Points.text = str(save_score)
	

func _refresh_score():
	update_score()

func _on_button_pressed():
	emit_signal("on_pressed_start")
	
