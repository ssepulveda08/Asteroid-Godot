extends CanvasLayer


signal  update_level

var score = 0
var config = ConfigFile.new()
var name_file = "user://highscore.save"
#config.load("res://Score.cfg")

func _ready():
	hide()

func resetting_score():
	score = 0 
	set_score_text(score)

func add_score(value):
	score += value
	set_score_text(score)
	validate_update_level(score)
	
func validate_update_level(score):
	
	if (score % 80) == 0:
		emit_signal("update_level") 
	
func set_score_text(value):
	$LabelScore.set_text(str(value , " Ptos"))
	
func validate_high_score():
	var err = config.load(name_file)
	var save_score = 0
	if err == OK:
		save_score = config.get_value("Score", "highest_score")
	else:
		print("Error")
		
	if 	save_score < score:
		save_score_if_is_the_highest()


func save_score_if_is_the_highest():
	var config = ConfigFile.new()
	config.set_value("Score", "highest_score", score)
	config.save(name_file)

