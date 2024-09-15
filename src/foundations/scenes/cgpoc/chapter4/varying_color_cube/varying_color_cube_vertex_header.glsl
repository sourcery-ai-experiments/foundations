#version 460 core
layout (location = 0) in vec3 f_position;
layout (location = 1) in vec4 f_color;
layout (location = 2) in vec3 f_normals;
layout (location = 3) in vec2 f_texture_coords;
layout (location = 4) in vec4 f_t_column0;
layout (location = 5) in vec4 f_t_column1;
layout (location = 6) in vec4 f_t_column2;
layout (location = 7) in vec4 f_t_column3;
layout (location = 8) in vec4 f_i_color;

uniform mat4 f_mvp;
uniform float f_tf;

out vec4 f_varying_color;
