shader_type canvas_item;

uniform float u_noise_level;

float rand(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}
void vertex() {
	
	
}

void fragment() {
	float rnd = rand(UV + TIME);
	
	if (rnd < u_noise_level)
	{
		COLOR = vec4(vec3(rand(vec2(rnd, rnd))), 1.0);
	}}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
