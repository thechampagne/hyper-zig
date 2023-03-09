// Copyright 2023 XXIV
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
pub const HYPER_ITER_CONTINUE = @as(c_int, 0);
pub const HYPER_ITER_BREAK = @as(c_int, 1);
pub const HYPER_HTTP_VERSION_NONE = @as(c_int, 0);
pub const HYPER_HTTP_VERSION_1_0 = @as(c_int, 10);
pub const HYPER_HTTP_VERSION_1_1 = @as(c_int, 11);
pub const HYPER_HTTP_VERSION_2 = @as(c_int, 20);
pub const HYPER_IO_PENDING = @import("std").zig.c_translation.promoteIntLiteral(c_int, 4294967295, .decimal);
pub const HYPER_IO_ERROR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 4294967294, .decimal);
pub const HYPER_POLL_READY = @as(c_int, 0);
pub const HYPER_POLL_PENDING = @as(c_int, 1);
pub const HYPER_POLL_ERROR = @as(c_int, 3);

pub const hyper_code = enum(c_uint) {
    OK,
    ERROR,
    INVALID_ARG,
    UNEXPECTED_EOF,
    ABORTED_BY_CALLBACK,
    FEATURE_NOT_ENABLED,
    INVALID_PEER_MESSAGE
};
pub const hyper_task_return_type = enum(c_uint) {
    TASK_EMPTY,
    TASK_ERROR,
    TASK_CLIENTCONN,
    TASK_RESPONSE,
    TASK_BUF
};

pub const hyper_body = opaque {};
pub const hyper_buf = opaque {};
pub const hyper_clientconn = opaque {};
pub const hyper_clientconn_options = opaque {};
pub const hyper_context = opaque {};
pub const hyper_error = opaque {};
pub const hyper_executor = opaque {};
pub const hyper_headers = opaque {};
pub const hyper_io = opaque {};
pub const hyper_request = opaque {};
pub const hyper_response = opaque {};
pub const hyper_task = opaque {};
pub const hyper_waker = opaque {};


pub const hyper_body_foreach_callback = ?fn (?*anyopaque, ?*const hyper_buf) callconv(.C) c_int;
pub const hyper_body_data_callback = ?fn (?*anyopaque, ?*hyper_context, [*c]?*hyper_buf) callconv(.C) c_int;
pub const hyper_request_on_informational_callback = ?fn (?*anyopaque, ?*hyper_response) callconv(.C) void;
pub const hyper_headers_foreach_callback = ?fn (?*anyopaque, [*c]const u8, usize, [*c]const u8, usize) callconv(.C) c_int;
pub const hyper_io_read_callback = ?fn (?*anyopaque, ?*hyper_context, [*c]u8, usize) callconv(.C) usize;
pub const hyper_io_write_callback = ?fn (?*anyopaque, ?*hyper_context, [*c]const u8, usize) callconv(.C) usize;

pub extern "C" fn hyper_version() [*c]const u8;
pub extern "C" fn hyper_body_new() ?*hyper_body;
pub extern "C" fn hyper_body_free(body: ?*hyper_body) void;
pub extern "C" fn hyper_body_data(body: ?*hyper_body) ?*hyper_task;
pub extern "C" fn hyper_body_foreach(body: ?*hyper_body, func: hyper_body_foreach_callback, userdata: ?*anyopaque) ?*hyper_task;
pub extern "C" fn hyper_body_set_userdata(body: ?*hyper_body, userdata: ?*anyopaque) void;
pub extern "C" fn hyper_body_set_data_func(body: ?*hyper_body, func: hyper_body_data_callback) void;
pub extern "C" fn hyper_buf_copy(buf: [*c]const u8, len: usize) ?*hyper_buf;
pub extern "C" fn hyper_buf_bytes(buf: ?*const hyper_buf) [*c]const u8;
pub extern "C" fn hyper_buf_len(buf: ?*const hyper_buf) usize;
pub extern "C" fn hyper_buf_free(buf: ?*hyper_buf) void;
pub extern "C" fn hyper_clientconn_handshake(io: ?*hyper_io, options: ?*hyper_clientconn_options) ?*hyper_task;
pub extern "C" fn hyper_clientconn_send(conn: ?*hyper_clientconn, req: ?*hyper_request) ?*hyper_task;
pub extern "C" fn hyper_clientconn_free(conn: ?*hyper_clientconn) void;
pub extern "C" fn hyper_clientconn_options_new() ?*hyper_clientconn_options;
pub extern "C" fn hyper_clientconn_options_set_preserve_header_case(opts: ?*hyper_clientconn_options, enabled: c_int) void;
pub extern "C" fn hyper_clientconn_options_set_preserve_header_order(opts: ?*hyper_clientconn_options, enabled: c_int) void;
pub extern "C" fn hyper_clientconn_options_free(opts: ?*hyper_clientconn_options) void;
pub extern "C" fn hyper_clientconn_options_exec(opts: ?*hyper_clientconn_options, exec: ?*const hyper_executor) void;
pub extern "C" fn hyper_clientconn_options_http2(opts: ?*hyper_clientconn_options, enabled: c_int) hyper_code;
pub extern "C" fn hyper_clientconn_options_headers_raw(opts: ?*hyper_clientconn_options, enabled: c_int) hyper_code;
pub extern "C" fn hyper_error_free(err: ?*hyper_error) void;
pub extern "C" fn hyper_error_code(err: ?*const hyper_error) hyper_code;
pub extern "C" fn hyper_error_print(err: ?*const hyper_error, dst: [*c]u8, dst_len: usize) usize;
pub extern "C" fn hyper_request_new() ?*hyper_request;
pub extern "C" fn hyper_request_free(req: ?*hyper_request) void;
pub extern "C" fn hyper_request_set_method(req: ?*hyper_request, method: [*c]const u8, method_len: usize) hyper_code;
pub extern "C" fn hyper_request_set_uri(req: ?*hyper_request, uri: [*c]const u8, uri_len: usize) hyper_code;
pub extern "C" fn hyper_request_set_uri_parts(req: ?*hyper_request, scheme: [*c]const u8, scheme_len: usize, authority: [*c]const u8, authority_len: usize, path_and_query: [*c]const u8, path_and_query_len: usize) hyper_code;
pub extern "C" fn hyper_request_set_version(req: ?*hyper_request, version: c_int) hyper_code;
pub extern "C" fn hyper_request_headers(req: ?*hyper_request) ?*hyper_headers;
pub extern "C" fn hyper_request_set_body(req: ?*hyper_request, body: ?*hyper_body) hyper_code;
pub extern "C" fn hyper_request_on_informational(req: ?*hyper_request, callback: hyper_request_on_informational_callback, data: ?*anyopaque) hyper_code;
pub extern "C" fn hyper_response_free(resp: ?*hyper_response) void;
pub extern "C" fn hyper_response_status(resp: ?*const hyper_response) u16;
pub extern "C" fn hyper_response_reason_phrase(resp: ?*const hyper_response) [*c]const u8;
pub extern "C" fn hyper_response_reason_phrase_len(resp: ?*const hyper_response) usize;
pub extern "C" fn hyper_response_headers_raw(resp: ?*const hyper_response) ?*const hyper_buf;
pub extern "C" fn hyper_response_version(resp: ?*const hyper_response) c_int;
pub extern "C" fn hyper_response_headers(resp: ?*hyper_response) ?*hyper_headers;
pub extern "C" fn hyper_response_body(resp: ?*hyper_response) ?*hyper_body;
pub extern "C" fn hyper_headers_foreach(headers: ?*const hyper_headers, func: hyper_headers_foreach_callback, userdata: ?*anyopaque) void;
pub extern "C" fn hyper_headers_set(headers: ?*hyper_headers, name: [*c]const u8, name_len: usize, value: [*c]const u8, value_len: usize) hyper_code;
pub extern "C" fn hyper_headers_add(headers: ?*hyper_headers, name: [*c]const u8, name_len: usize, value: [*c]const u8, value_len: usize) hyper_code;
pub extern "C" fn hyper_io_new() ?*hyper_io;
pub extern "C" fn hyper_io_free(io: ?*hyper_io) void;
pub extern "C" fn hyper_io_set_userdata(io: ?*hyper_io, data: ?*anyopaque) void;
pub extern "C" fn hyper_io_set_read(io: ?*hyper_io, func: hyper_io_read_callback) void;
pub extern "C" fn hyper_io_set_write(io: ?*hyper_io, func: hyper_io_write_callback) void;
pub extern "C" fn hyper_executor_new() ?*const hyper_executor;
pub extern "C" fn hyper_executor_free(exec: ?*const hyper_executor) void;
pub extern "C" fn hyper_executor_push(exec: ?*const hyper_executor, task: ?*hyper_task) hyper_code;
pub extern "C" fn hyper_executor_poll(exec: ?*const hyper_executor) ?*hyper_task;
pub extern "C" fn hyper_task_free(task: ?*hyper_task) void;
pub extern "C" fn hyper_task_value(task: ?*hyper_task) ?*anyopaque;
pub extern "C" fn hyper_task_type(task: ?*hyper_task) hyper_task_return_type;
pub extern "C" fn hyper_task_set_userdata(task: ?*hyper_task, userdata: ?*anyopaque) void;
pub extern "C" fn hyper_task_userdata(task: ?*hyper_task) ?*anyopaque;
pub extern "C" fn hyper_context_waker(cx: ?*hyper_context) ?*hyper_waker;
pub extern "C" fn hyper_waker_free(waker: ?*hyper_waker) void;
pub extern "C" fn hyper_waker_wake(waker: ?*hyper_waker) void;
