pub const scene_type = enum(usize) {
    point,
    point_rotating,
    triangle,
    triangle_animated,
    cubes_animated,
    math_vector_arithmetic,
    linear_colorspace,
    circle,
    sphere,
    line,
};

pub const scenes = union(scene_type) {
    point: *point,
    point_rotating: *point_rotating,
    triangle: *triangle,
    triangle_animated: *triangle_animated,
    cubes_animated: *cubes_animated,
    math_vector_arithmetic: *math_vector_arithmetic,
    linear_colorspace: *linear_colorspace,
    circle: *circle,
    sphere: *sphere,
    line: *line,
};

const point = @import("../scenes/point/point.zig");
const point_rotating = @import("../scenes/point_rotating/point_rotating.zig");
const triangle = @import("../scenes/triangle/triangle.zig");
const triangle_animated = @import("../scenes/triangle_animated/triangle_animated.zig");
const math_vector_arithmetic = @import("../scenes/math_vector_arithmetic/math_vector_arithmetic.zig");
const linear_colorspace = @import("../scenes/linear_colorspace/linear_colorspace.zig");
const cubes_animated = @import("../scenes/cubes_animated/cubes_animated.zig");
const circle = @import("../scenes/circle/circle.zig");
const sphere = @import("../scenes/sphere/sphere.zig");
const line = @import("../scenes/line/line.zig");
