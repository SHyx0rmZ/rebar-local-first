-module(rebar_local_then_git_resource).
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

-spec transform(tuple()) -> tuple().

transform({ local_then_git, Path, Repository, Version }) ->
    AbsolutePath = filename:absname(Path),
    case file:read_file_info(AbsolutePath) of
        { ok, _ } ->
            { git, AbsolutePath, Version };
        { error, _ } ->
            { git, Repository, Version }
    end.
