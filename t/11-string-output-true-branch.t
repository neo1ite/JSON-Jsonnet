use Test2::V0;
use JSON::Jsonnet;

my $vm = JSON::Jsonnet->new(
    string_output => 1,   # ветка exists + true
);

my $out = $vm->evaluate_snippet("so1", '"hi"');
like $out, qr/^hi\n?$/, "string_output=>1 via new (true branch)";

done_testing;
