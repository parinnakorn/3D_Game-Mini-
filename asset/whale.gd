extends Node3D
@export var speed: float = 2.0
@export var forward_limit: float = -25.0   # ไปข้างหน้า (-X)
@export var back_limit: float = -10.0       # กลับมาที่จุดเริ่ม (X=0)

var going_forward: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim = $AnimationPlayer.get_animation("Armature|Swim")
	anim.loop = true
	$AnimationPlayer.play("Armature|Swim")
func _physics_process(delta: float) -> void:
	if going_forward:
		global_translate(Vector3(-speed * delta, 0, 0)) # เดินไป –X ตามแกนโลก
		if global_position.x <= forward_limit:
			going_forward = false
			rotate_y(PI) # หมุนหน้าโมเดลเฉย ๆ
	else:
		global_translate(Vector3(speed * delta, 0, 0))  # เดินกลับ +X ตามแกนโลก
		if global_position.x >= back_limit:
			going_forward = true
			rotate_y(PI)
