shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform vec4 blue_lightest = vec4(-1);
uniform vec4 blue_light = vec4(-1);
uniform vec4 blue_mid = vec4(-1);
uniform vec4 blue_darkest = vec4(-1);
uniform vec4 theme_lightest = vec4(-1);
uniform vec4 theme_light = vec4(-1);
uniform vec4 theme_mid = vec4(-1);
uniform vec4 theme_darkest = vec4(-1);

void fragment() {
	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
	if (col == blue_lightest)
		COLOR = theme_lightest;
	else if (col == blue_light)
		COLOR = theme_light;
	else if (col == blue_mid)
		COLOR = theme_mid;
	else if (col == blue_darkest)
		COLOR = theme_darkest;
	else
		COLOR = col;
}