//const std = @import("std");
const print = @import("std").debug.print;

pub fn main() void {
    print("Hello, world!\n", .{});
}

//Note print can fail normally when writing ot file so ! is used if it can fail
// pub fn main() !void {
//    const stdout = std.io.getStdOut().writer();
//    try stdout.print("Hello, {s}!\n", .{"world"});
//}  