-module(rebar_local_then_git_deps).

-export([ init/1 ]).

-spec init(rebar_state:t()) -> { ok, rebar_state:t() }.

init(State) ->
    { ok, rebar_state:add_resource(State, { local_then_git, rebar_local_then_git_resource }) }.
