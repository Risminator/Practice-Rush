shader_type canvas_item;

uniform bool tint = false;
uniform vec3 color = vec3(1, 1, 1);
uniform float mix_weight = 1;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (tint) {
		vec3 colored_texture_rgb = mix(texture_color.rgb, color, mix_weight);
		COLOR *= vec4(colored_texture_rgb, texture_color.a);
	} else {
		COLOR = texture_color;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
