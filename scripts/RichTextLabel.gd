extends RichTextLabel


func _process(delta):
	text = "Score : " + str(GameVariables.game_score) + "\nBricks broken: " + str(GameVariables.bricks_broken)
	text += "\nBalls remaining: " + str(GameVariables.balls_remaining)
	text += "\nBalls in game: " + str(GameVariables.balls_in_game)
