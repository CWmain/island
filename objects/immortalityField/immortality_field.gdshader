shader_type canvas_item;

void fragment() {
	// Called for every pixel the material is visible on.
	
	if (distance(UV, vec2(0.5,0.5)) > 0.5){
		COLOR.a = 0.0;
	} 
}
