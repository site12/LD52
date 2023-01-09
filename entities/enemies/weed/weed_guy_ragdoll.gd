extends Node3D


# Called when the node enters the scene tree for the first time.
func ragdoll():
	$Carrot/Carrot_Rig/Skeleton3D.physical_bones_start_simulation()
