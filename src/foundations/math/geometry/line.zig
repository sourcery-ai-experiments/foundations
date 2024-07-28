direction: vector.vec3,
direction_squared: f32,
moment: vector.vec3,

const Line = @This();

pub fn init(p0: vector.vec3, p1: vector.vec3) Line {
    const direction = vector.normalize(vector.sub(p1, p0));
    return .{
        .direction = direction,
        .direction_squared = vector.dotProduct(direction, direction),
        .moment = vector.crossProduct(p0, direction),
    };
}

pub fn closestPointToOrigin(self: Line) vector.vec3 {
    const rv = vector.crossProduct(self.direction, self.moment);
    return vector.mul(1.0 / self.direction_squared, rv);
}

pub fn pointOnLine(self: Line, t: f32) vector.vec3 {
    const p0 = self.closestPointToOrigin();
    return vector.add(p0, vector.mul(t, self.direction));
}

pub fn distanceToPoint(self: Line, p: vector.vec3) f32 {
    var rv = vector.crossProduct(self.direction, p);
    rv = vector.add(rv, self.moment);
    return vector.magnitude(rv) / vector.magnitude(self.direction);
}

const vector = @import("../vector.zig");
