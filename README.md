# Sonic-Codex
Sonic Engine in Open Code which replicates the gameplay of Sonic's 3D games in momentum format, combining the best of adventure games and pre-Boost 3D games. with better graphics, more fun gameplay, etc.

## Godot Momentum Prototype (GDScript)
Use this CharacterBody3D script for a momentum-style controller you can drop into a test scene.

1. Create a `CharacterBody3D` in a new Godot 4 scene.
2. Attach `godot/MomentumCharacterBody3D.gd`.
3. Add input actions: `move_left`, `move_right`, `move_forward`, `move_back`, and `jump`.
4. Add a `CollisionShape3D` and a `MeshInstance3D` so you can see and collide.
5. Press Play and tweak exported values for speed, acceleration, and air control.

The script keeps horizontal velocity between frames to preserve momentum, applies different acceleration when grounded vs. airborne, and blends turning to avoid instant direction swaps.【F:godot/MomentumCharacterBody3D.gd†L1-L85】
