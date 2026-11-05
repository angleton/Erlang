-module(crud_store_tests).
-include_lib("eunit/include/eunit.hrl").

create_test() ->
    ?assertEqual({ok, #{user1 => "Ada"}},
                 crud_store:create(user1, "Ada", crud_store:new())).

read_test() ->
    Store = #{user1 => "Ada"},
    ?assertEqual({ok, "Ada"}, crud_store:read(user1, Store)).

update_test() ->
    Store = #{user1 => "Ada"},
    ?assertEqual({ok, #{user1 => "Grace"}},
                 crud_store:update(user1, "Grace", Store)).

delete_test() ->
    Store = #{user1 => "Ada"},
    ?assertEqual({ok, "Ada", #{}},
                 crud_store:delete(user1, Store)).

missing_or_duplicate_test() ->
    Store = #{user1 => "Ada"},
    ?assertEqual({error, already_exists},
                 crud_store:create(user1, "Grace", Store)),
    ?assertEqual({error, not_found},
                 crud_store:read(user2, Store)),
    ?assertEqual({error, not_found},
                 crud_store:update(user2, "Grace", Store)),
    ?assertEqual({error, not_found},
                 crud_store:delete(user2, Store)).