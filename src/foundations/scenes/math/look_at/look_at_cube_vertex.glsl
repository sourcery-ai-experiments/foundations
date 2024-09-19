mat4 f_mvp = p_matrix * v_matrix;
uniform mat4 f_transform;

out vec4 f_frag_color;
out vec3 fo_normals;

void main()
{
    vec4 pos = f_mvp * f_transform * vec4(f_position.xyz, 1.0);
    gl_Position = pos;
    f_frag_color = f_color;
    fo_normals = f_normals * 0.5 + 0.5;
}