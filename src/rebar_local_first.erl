-module(rebar_local_first).

-export([ init/1 ]).

-spec init(rebar_state:t()) -> { ok, rebar_state:t() }.

init(State) ->
    { ok, rebar_state:add_resource(State, { local_first, rebar_local_first_resource }) }.
