extends Control

func _on_coin_collected(coins):
	
	$Coins.text = str(coins)
	
func _process(_delta):
	# กด restart รีโหลดฉาก
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
