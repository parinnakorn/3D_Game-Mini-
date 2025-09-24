extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim = $AnimationPlayer.get_animation("TentacleArmature|TentacleArmature|TentacleArmature|Tentacle_Attack2|TentacleArma")
	anim.loop = true
	$AnimationPlayer.play("TentacleArmature|TentacleArmature|TentacleArmature|Tentacle_Attack2|TentacleArma")
