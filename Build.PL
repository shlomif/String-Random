use strict;
use warnings;

use lib './inc';

use Test::Run::Builder;

my $builder = Test::Run::Builder->new(
    module_name         => 'String::Random',
    license             => 'perl',
    dist_author         => 'Shlomi Fish <shlomif@cpan.org>',
    configure_requires =>
    {
        'Module::Build'  => '0.36',
    },
    requires =>
    {
        'Carp'          => 0,
        'Exporter'      => 0,
        'strict'        => 0,
        'Test::More'    => 0,
        'warnings'      => 0,
        'vars'          => 0,
    },
);

$builder->create_build_script();

# vi: set ai et:
