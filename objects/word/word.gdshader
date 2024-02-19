shader_type canvas_item;

uniform vec4 color : source_color;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.rgb = color.rgb;
}