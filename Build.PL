use strict;
use warnings;

use lib './inc';

use Test::Run::Builder;

my $builder = Test::Run::Builder->new(
    module_name         => 'String::Random',
    license             => 'perl',
    dist_author         => 'Steven Pritchard <steve@silug.org>',
    requires => {
        'Test::More'    => 0,
    },
);

$builder->create_build_script();

# vi: set ai et:
