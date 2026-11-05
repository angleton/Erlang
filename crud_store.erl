-module(crud_store).
-export([new/0, create/3, read/2, update/3, delete/2]).

new() ->
    #{}.

create(Key, Value, Store) ->
    case maps:is_key(Key, Store) of
        true  -> {error, already_exists};
        false -> {ok, Store#{Key => Value}}
    end.

read(Key, Store) ->
    case maps:find(Key, Store) of
        {ok, Value} -> {ok, Value};
        error       -> {error, not_found}
    end.

update(Key, Value, Store) ->
    case maps:is_key(Key, Store) of
        true  -> {ok, Store#{Key => Value}};
        false -> {error, not_found}
    end.

delete(Key, Store) ->
    case maps:take(Key, Store) of
        {Value, NewStore} -> {ok, Value, NewStore};
        error             -> {error, not_found}
    end.