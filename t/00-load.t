use Test2::V0;

ok lives {
    require JSON::Jsonnet;
    JSON::Jsonnet->VERSION;
}, 'JSON::Jsonnet loads';

done_testing;
