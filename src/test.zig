pub fn main() !void {
    _ = math.vector;
    _ = math.rotation;
    _ = math.float;
    _ = math.matrix;
}

test {
    std.testing.refAllDeclsRecursive(@This());
}

const std = @import("std");
const math = @import("foundations/math/math.zig");
