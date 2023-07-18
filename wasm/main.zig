const std = @import("std");
const utils = @import("./utils.zig");

const init_mem = utils.init_mem;

const allocator = std.heap.page_allocator;

export fn init_memory(num: i32) [*]i32  {
    var root: [*]i32 = init_mem(i32, 100, allocator);

    for(root, 0..100) |_, i| {
        root[i] = -1;
    }

    root[0] = num;

    return root;
}
