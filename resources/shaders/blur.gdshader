shader_type canvas_item;

uniform float lod: hint_range(0.0, 5) = 0.0;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest_mipmap_anisotropic;

void fragment(){
	
	vec4 color = textureLod(screen_texture, SCREEN_UV, lod);
	COLOR = color;
}