distance: usize = 0,
plane_rotation: [3]f32 = .{
    std.math.pi,
    std.math.pi,
    std.math.pi,
},
plane_translate: [3]f32 = .{ 0, -15, -20 },
plane_updated: bool = true,
cube_rotation: [3]f32 = .{
    std.math.pi,
    std.math.pi + std.math.pi * 0.25,
    std.math.pi - std.math.pi * 0.25,
},
cube_translate: [3]f32 = .{ 3, -2, 2 },
cube_updated: bool = true,
closest_point_to_origin: [4]f32 = .{ 0, 0, 0, 0 },
origin_distance: f32 = 0,
cube_distance: f32 = 0,
cube_point: [4]f32 = .{ 0, 0, 0, 0 },

const PlaneDistanceUI = @This();

pub fn draw(self: *PlaneDistanceUI) void {
    var buf: [250]u8 = undefined;
    const vp: *c.ImGuiViewport = c.igGetMainViewport();
    const pos = c.ImVec2_ImVec2_Float(vp.WorkPos.x + 50, vp.WorkPos.y + 50);
    c.igSetNextWindowPos(pos.*, c.ImGuiCond_FirstUseEver, c.ImVec2_ImVec2_Float(0, 0).*);
    const size = c.ImVec2_ImVec2_Float(550, 680);
    c.igSetNextWindowSize(size.*, c.ImGuiCond_FirstUseEver);
    _ = c.igBegin("Distance to Plane", null, 0);
    {
        const txt = std.fmt.bufPrintZ(&buf, "Closest point to origin: ({d:.3}, {d:.3}, {d:.3}, {d:.3})", .{
            self.closest_point_to_origin[0],
            self.closest_point_to_origin[1],
            self.closest_point_to_origin[2],
            self.closest_point_to_origin[3],
        }) catch @panic("bufsize too small");
        c.igText(@ptrCast(txt));
    }
    {
        const txt = std.fmt.bufPrintZ(&buf, "Plane distance to origin: {d:.3}", .{
            self.origin_distance,
        }) catch @panic("bufsize too small");
        c.igText(@ptrCast(txt));
    }
    {
        const txt = std.fmt.bufPrintZ(&buf, "Closest point to cube: ({d:.3}, {d:.3}, {d:.3}, {d:.3})", .{
            self.cube_point[0],
            self.cube_point[1],
            self.cube_point[2],
            self.cube_point[3],
        }) catch @panic("bufsize too small");
        c.igText(@ptrCast(txt));
    }
    {
        const txt = std.fmt.bufPrintZ(&buf, "Plane distance to cube: {d:.3}", .{
            self.cube_distance,
        }) catch @panic("bufsize too small");
        c.igText(@ptrCast(txt));
    }

    if (c.igTreeNode_Str("plane rotation")) {
        if (c.igSliderFloat("x", &self.plane_rotation[0], 0, std.math.pi * 2.0, "%.3f", c.ImGuiSliderFlags_None)) self.plane_updated = true;
        if (c.igSliderFloat("y", &self.plane_rotation[1], 0, std.math.pi * 2.0, "%.3f", c.ImGuiSliderFlags_None)) self.plane_updated = true;
        if (c.igSliderFloat("z", &self.plane_rotation[2], 0, std.math.pi * 2.0, "%.3f", c.ImGuiSliderFlags_None)) self.plane_updated = true;
        c.igTreePop();
    }
    if (c.igTreeNode_Str("plane translate")) {
        if (c.igSliderFloat("x", &self.plane_translate[0], -100, 100, "%.3f", c.ImGuiSliderFlags_None)) self.plane_updated = true;
        if (c.igSliderFloat("y", &self.plane_translate[1], -100, 100, "%.3f", c.ImGuiSliderFlags_None)) self.plane_updated = true;
        if (c.igSliderFloat("z", &self.plane_translate[2], -100, 100, "%.3f", c.ImGuiSliderFlags_None)) self.plane_updated = true;
        c.igTreePop();
    }
    if (c.igTreeNode_Str("cube rotation")) {
        if (c.igSliderFloat("x", &self.cube_rotation[0], 0, std.math.pi * 2.0, "%.3f", c.ImGuiSliderFlags_None)) self.cube_updated = true;
        if (c.igSliderFloat("y", &self.cube_rotation[1], 0, std.math.pi * 2.0, "%.3f", c.ImGuiSliderFlags_None)) self.cube_updated = true;
        if (c.igSliderFloat("z", &self.cube_rotation[2], 0, std.math.pi * 2.0, "%.3f", c.ImGuiSliderFlags_None)) self.cube_updated = true;
        c.igTreePop();
    }
    if (c.igTreeNode_Str("cube translate")) {
        if (c.igSliderFloat("x", &self.cube_translate[0], -100, 100, "%.3f", c.ImGuiSliderFlags_None)) self.cube_updated = true;
        if (c.igSliderFloat("y", &self.cube_translate[1], -100, 100, "%.3f", c.ImGuiSliderFlags_None)) self.cube_updated = true;
        if (c.igSliderFloat("z", &self.cube_translate[2], -100, 100, "%.3f", c.ImGuiSliderFlags_None)) self.cube_updated = true;
        c.igTreePop();
    }
    c.igEnd();
}

const std = @import("std");
const c = @import("../../../c.zig").c;
const math = @import("../../../math/math.zig");
