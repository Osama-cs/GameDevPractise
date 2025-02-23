shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
// uniform is how you make variables that can be accessed anywhere in the code
uniform float lerp_percent : hint_range(0.0, 1.0);

void fragment() {
	// Creates a texture colour varaiable of vec 4 (red, green, blue and aplha).
	// the texture function tells us that it whats to read the value of a pixel at the spcified texture and uv. 
	// This code is saying grab the colour of the current pixel we are looking at and asign the colour output to that texture_colour. 
	vec4 texture_colour = texture(TEXTURE, UV);
	// mix is linear interplation. We are going from our texture colour to white with the weight of lerp_percent. (change the lerp_percent value in the editor to see what i mean by white)
	// the vec4 in the mix is a colour, and to get white you need a value of 1 in RGB. But you need the texture colour here to tell it to cover just the texture and not the whole sqaure.
	// the a in texture_colour.a is how you access the aplha channel.
	vec4 final_colour = mix(texture_colour, vec4(1.0, 1.0, 1.0, texture_colour.a), lerp_percent);
	COLOR = final_colour;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
