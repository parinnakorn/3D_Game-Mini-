extends Area3D

@export var hub_path: NodePath  # Path ไปยัง HUB Control

@onready var hub = get_node(hub_path)

func _ready():
	# ซ่อนข้อความตอนเริ่ม
	if hub.has_node("win"):
		hub.get_node("win").visible = false
	# เชื่อมสัญญาณชน
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):  # ตรวจว่าชนผู้เล่น
		if hub.has_node("win"):
			hub.get_node("win").visible = true
