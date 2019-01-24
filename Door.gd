extends Area2D

export(String, FILE, "*.tscn") var nextScene

func _on_Door_body_entered(body):
	print("collided with: " + body.name)
	if(body.name == "Player"):
		get_tree().change_scene(nextScene)
