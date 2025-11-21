use strict;
use warnings;
use ExtUtils::MakeMaker;

my $prefix = $ENV{JSONNET_PREFIX};

my $inc  = '';
my $libs = '-ljsonnet -lstdc++';

if ($prefix) {
    $inc  = "-I$prefix/include";
    $libs = "-L$prefix/lib $libs";
} else {
    my $pc_libs   = `pkg-config --libs libjsonnet 2>/dev/null`;
    my $pc_cflags = `pkg-config --cflags libjsonnet 2>/dev/null`;
    chomp($pc_libs, $pc_cflags);
    $inc  = $pc_cflags if $pc_cflags;
    $libs = $pc_libs   if $pc_libs;
}

WriteMakefile(
    NAME             => 'JSON::Jsonnet',
    VERSION_FROM     => 'lib/JSON/Jsonnet.pm',
    ABSTRACT_FROM    => 'lib/JSON/Jsonnet.pm',
    AUTHOR           => 'Sergey Kovalev <info@neolite.ru>',
    LICENSE          => 'perl_5',

    MIN_PERL_VERSION => '5.30.0',

    LIBS             => [$libs],
    INC              => $inc,
    XS               => { 'Jsonnet.xs' => 'Jsonnet.c' },

    TYPEMAPS         => ['typemap'],

    clean            => { FILES => 'Jsonnet.c Jsonnet.o cover_db MYMETA.*' },

    PREREQ_PM => {
        'JSON::MaybeXS' => 0,
        'Test2::V0'     => 0,
    },

    META_MERGE => {
        'meta-spec' => { version => 2 },  # CPAN Meta Spec v2 :contentReference[oaicite:1]{index=1}
        resources => {
            license    => ['https://dev.perl.org/licenses/'],
            repository => {
                type => 'git',
                url  => 'https://github.com/neo1ite/JSON-Jsonnet.git',
                web  => 'https://github.com/neo1ite/JSON-Jsonnet',
            },
            bugtracker => {
                web => 'https://github.com/neo1ite/JSON-Jsonnet/issues',
            },
        },
        prereqs => {
            configure => {
                requires => {
                    'ExtUtils::MakeMaker' => 0,
                },
            },
        },
    },

    TEST_REQUIRES => {
        'Test::Pod'            => 0,
        'Test::Pod::Coverage'  => 0,
        'Test::CPAN::Meta'     => 0,
    },
);
