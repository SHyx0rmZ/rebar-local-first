rebar_local_first
=====

Plugin to first try and resolve dependencies locally

Build
-----

    $ rebar3 compile

Use
---

Add the plugin to your rebar config:

    { plugins, [
        { rebar_local_first, ".*", { git, "git://github.com/SHyx0rmZ/rebar_local_first.git", { tag, "0.1.0" } } }
    ] }.
