scene_instance: ?ui.ui_state.scenes = null,
next_scene_type: ?ui.ui_state.scene_type = null,

allocator: std.mem.Allocator,

const Scenes = @This();

pub fn init(allocator: std.mem.Allocator) *Scenes {
    const scenes = allocator.create(Scenes) catch @panic("OOM");
    errdefer allocator.destroy(scenes);
    scenes.* = .{
        .allocator = allocator,
    };
    scenes.initScene(ui.ui_state.scene_type.line);
    return scenes;
}

pub fn setScene(self: *Scenes, dt: ui.ui_state.scene_type) void {
    self.next_scene_type = dt;
}

fn updateSceneType(self: *Scenes) void {
    const dt = self.next_scene_type orelse return;
    self.next_scene_type = null;
    if (self.scene_instance) |cdt| if (cdt == dt) return;
    self.deinitScene();
    self.initScene(dt);
}

pub fn deinit(self: *Scenes) void {
    self.deinitScene();
    self.allocator.destroy(self);
}

fn initScene(self: *Scenes, dt: ui.ui_state.scene_type) void {
    self.scene_instance = switch (dt) {
        inline else => |dtag| @unionInit(ui.ui_state.scenes, @tagName(dtag), std.meta.Child(
            std.meta.TagPayload(
                ui.ui_state.scenes,
                dtag,
            ),
        ).init(self.allocator)),
    };
}

fn deinitScene(self: Scenes) void {
    if (self.scene_instance) |di| {
        switch (di) {
            inline else => |d| d.deinit(self.allocator),
        }
    }
}

pub fn updateScene(self: *Scenes, _: f64) void {
    self.updateSceneType();
}

pub fn drawScene(self: Scenes, frame_time: f64) void {
    if (self.scene_instance) |di| {
        switch (di) {
            inline else => |d| d.draw(frame_time),
        }
    }
}

const std = @import("std");
const ui = @import("../ui/ui.zig");