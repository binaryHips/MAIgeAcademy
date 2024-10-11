// NOTE: Shader automatically converted from Godot Engine 4.3.stable's CanvasItemMaterial.

shader_type canvas_item;
render_mode blend_mix;

uniform vec4 color: source_color;

uniform sampler2D clouds : repeat_enable;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

float overlay(float a, float b){
	
	if (a >= 0.5){
		
		return (1.0 - 2.0 * (1.0 - a) * (1.0 - b));
		
	} else {
		
		return 2.0*a*b;
	}
}


void fragment() {
		vec4 tex_col = textureLod(screen_texture, SCREEN_UV, 0.0);
		
		float cloud_val = texture(clouds, UV - vec2(TIME/100.0, sin(TIME/100.0))).x;
		cloud_val *= 0.15;
		
		tex_col.r = overlay(tex_col.r, color.r - cloud_val);
		tex_col.g = overlay(tex_col.g, color.g - cloud_val);
		tex_col.b = overlay(tex_col.b, color.b - cloud_val);
		
        COLOR =tex_col;

}