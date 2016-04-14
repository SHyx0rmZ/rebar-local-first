-module(rebar_local_first_resource).
-behavior(rebar_resource).

-export([ lock/2, download/3, needs_update/2, make_vsn/1 ]).

lock(Dir, Source) ->
    rebar_git_resource:lock(Dir, transform(Source)).

download(Dir, Source, State) ->
    rebar_git_resource:download(Dir, transform(Source), State).

needs_update(Dir, Source) ->
    rebar_git_resource:needs_update(Dir, transform(Source)).

make_vsn(Dir) ->
    rebar_git_resource:make_vsn(Dir).

-spec transform
    ({ local_first, atom(), tuple(), tuple() }) -> tuple();
    ({ local_first, atom(), tuple(), string() }) -> tuple();
    ({ local_first, atom(), string(), tuple() }) -> tuple();
    ({ local_first, atom(), string(), string() }) -> tuple().

transform({ local_first, Method, { LocalPath, LocalVersion }, { RemotePath, RemoteVersion } }) ->
    AbsoluteLocalPath = filename:absname(LocalPath),
    decide(AbsoluteLocalPath, { Method, AbsoluteLocalPath, LocalVersion }, { Method, RemotePath, RemoteVersion });
transform({ local_first, Method, LocalPath, { RemotePath, RemoteVersion } }) when not is_tuple(LocalPath) ->
    AbsoluteLocalPath = filename:absname(LocalPath),
    decide(AbsoluteLocalPath, { Method, LocalPath }, { Method, RemotePath, RemoteVersion });
transform({ local_first, Method, { LocalPath, LocalVersion }, RemotePath }) when not is_tuple(RemotePath) ->
    AbsoluteLocalPath = filename:absname(LocalPath),
    decide(AbsoluteLocalPath, { Method, AbsoluteLocalPath, LocalVersion }, { Method, RemotePath });
transform({ local_first, Method, LocalPath, RemotePath }) ->
    AbsoluteLocalPath = filename:absname(LocalPath),
    decide(AbsoluteLocalPath, { Method, AbsoluteLocalPath }, { Method, RemotePath }).

-spec decide(string(), tuple(), tuple()) -> tuple().

decide(AbsoluteLocalPath, LocalTuple, RemoteTuple) ->
    case file:read_file_info(AbsoluteLocalPath) of
        { ok, _ } ->
            LocalTuple;
        { error, _ } ->
            RemoteTuple
    end.
