shader_type canvas_item;

uniform float u_noise_level;

// Pseudorandom algorithm using sin, dot product, and some constants
float rand(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// Fragment or pixel shader
void fragment() {
//	Gets a random value using uv coords and time
	float rnd = rand(UV + rand(vec2(TIME, TIME)));
	
	if (rnd < u_noise_level)
	{
		COLOR = vec4(vec3(rand(vec2(rnd, rnd))), 1.0);
	}}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
