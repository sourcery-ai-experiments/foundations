uniform mat4 f_mvp;
out vec2 f_tc;
out vec4 f_frag_color;
out vec3 fo_normals;

void main()
{
    mat4 f_transform = mat4(
        f_t_column0,
        f_t_column1,
        f_t_column2,
        f_t_column3
    );
    vec4 f_pos = f_mvp * f_transform * vec4(f_position.xyz, 1.0);
    gl_Position = f_pos;
    f_tc = f_texture_coords;
    f_frag_color = f_i_color;
    fo_normals = f_normals;
}