rebar_local_then_git_deps
=====

A rebar plugin

Build
-----

    $ rebar3 compile

Use
---

Add the plugin to your rebar config:

    {plugins, [
        { rebar_local_then_git_deps, ".*", {git, "git@host:user/rebar_local_then_git_deps.git", {tag, "0.1.0"}}}
    ]}.

Then just call your plugin directly in an existing application:


    $ rebar3 rebar_local_then_git_deps
    ===> Fetching rebar_local_then_git_deps
    ===> Compiling rebar_local_then_git_deps
    <Plugin Output>
