ui_state: vma_ui,
vectors: [100]object.object = undefined,
num_vectors: usize = 0,

const MathVectorArithmetic = @This();

const vertex_shader: []const u8 = @embedFile("mva_vertex.glsl");
const frag_shader: []const u8 = @embedFile("mva_frag.glsl");

pub fn init(allocator: std.mem.Allocator) *MathVectorArithmetic {
    const p = allocator.create(MathVectorArithmetic) catch @panic("OOM");
    p.* = .{
        .ui_state = .{},
    };
    return p;
}

pub fn deinit(self: *MathVectorArithmetic, allocator: std.mem.Allocator) void {
    allocator.destroy(self);
}

pub fn draw(self: *MathVectorArithmetic, _: f64) void {
    if (self.num_vectors != self.ui_state.num_vectors) {
        if (self.ui_state.num_vectors == 0) {
            self.clearVectors();
        } else {
            self.addVector();
        }
    }
    rhi.drawObjects(self.vectors[0..self.num_vectors]);
    self.ui_state.draw();
}

fn addVector(self: *MathVectorArithmetic) void {
    const vec: math.vector.vec3 = self.ui_state.vectors[self.num_vectors];
    var positions: [3][3]f32 = undefined;
    var pi: usize = 0;
    while (pi < 3) : (pi += 1) {
        const pv: math.vector.vec3 = object.triangle.default_positions[pi];
        positions[pi] = math.vector.add(pv, vec);
    }
    //object.triangle.default_positions;

    self.vectors[self.num_vectors] = .{
        .triangle = object.triangle.init(
            vertex_shader,
            frag_shader,
            positions,
            object.triangle.default_colors,
        ),
    };
    self.num_vectors += 1;
}

fn clearVectors(self: *MathVectorArithmetic) void {
    rhi.deleteObjects(self.vectors[0..self.num_vectors]);
    self.num_vectors = 0;
}

const std = @import("std");
const vma_ui = @import("math_vector_arithmetic_ui.zig");
const rhi = @import("../../rhi/rhi.zig");
const object = @import("../../object/object.zig");
const math = @import("../../math/math.zig");