shader_type canvas_item;

uniform vec2 center;
uniform float force;
uniform float size;
uniform float thickness;

void fragment() {
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 scaledUV = (SCREEN_UV - vec2(0.5, 0.0))+ vec2(0.5, 0.0);
	float mask = (smoothstep(size-0.5, size,  length(scaledUV - center)));
	vec2 disp = normalize(scaledUV - center) * force * mask;
	COLOR = vec4( 
			texture(SCREEN_TEXTURE, SCREEN_UV + disp).r, 
			texture(SCREEN_TEXTURE, SCREEN_UV).g,
			texture(SCREEN_TEXTURE, SCREEN_UV - disp).b, 
		1.0);
	//COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - disp);
	//COLOR.rgb = vec3(mask); // for debugging
}