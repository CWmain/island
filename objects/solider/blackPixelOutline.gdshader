shader_type canvas_item;

void fragment() {
	// Called for every pixel the material is visible on.
	// All pixels 1 texture pixel away from the border should be black
	
	if(UV.x < 0.0625 || UV.x > 1.0-0.0625 || UV.y < 0.0625 || UV.y > 1.0-0.0625){
		COLOR = vec4(0,0,0,1);
	}
}
