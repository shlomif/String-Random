# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..13\n"; }
END {print "not ok 1\n" unless $loaded;}
use String::Random;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

$failed=0;

# 2: Make sure we can create a new object
$foo=new String::Random;
$bar=new String::Random; # A spare for later
if (!defined($foo) || !defined($bar))
{
    print "not ";
    $failed++;
}
print "ok 2\n";

# 3: Test function interface to randpattern()
$abc=String::Random::random_string("012", ['a'], ['b'], ['c']);
if ($abc ne 'abc')
{
    print "not ";
    $failed++;
}
print "ok 3\n";

# 4: Make sure the function didn't pollute $foo
if (defined($foo->{'0'}))
{
    print "not ";
    $failed++;
}
print "ok 4\n";

# Try the object method...
$foo->{'x'}=['a'];
$foo->{'y'}=['b'];
$foo->{'z'}=['c'];
# 5: passing a scalar, in a scalar context
$abc=$foo->randpattern("xyz");
if ($abc ne 'abc')
{
    print "not ";
    $failed++;
}
print "ok 5\n";
# 6: Make sure the from_pattern() interface still works
$abc=$foo->from_pattern("xyz");
if ($abc ne 'abc')
{
    print "not ";
    $failed++;
}
print "ok 6\n";
# 7: passing a list, in a scalar context
$abc=$foo->randpattern(qw(x y z));
if ($abc ne 'abc')
{
    print "not ";
    $failed++;
}
print "ok 7\n";

# 8: Check one of the built-in patterns to make
# sure it contains what we think it should
@upcase=("A".."Z");
for ($n=0;$n<26;$n++)
{
    if (!defined($foo->{'C'}->[$n]) || ($upcase[$n] ne $foo->{'C'}->[$n]))
    {
	print "not ";
	$failed++;
	last;
    }
}
print "ok 8\n";

# 9: Test modifying one of the built-in patterns
$foo->{'C'}=['n'];
if ($foo->randpattern("C") ne "n")
{
    print "not ";
    $failed++;
}
print "ok 9\n";

# 10: Make sure we haven't clobbered anything in an existing object
if ($bar->randpattern("C") eq "n")
{
    print "not ";
    $failed++;
}
print "ok 10\n";

# 11: Make sure we haven't clobbered anything in a new object
$baz=new String::Random;
if (!defined($baz) || ($baz->randpattern("C") eq "n"))
{
    print "not ";
    $failed++;
}
print "ok 11\n";

# 12: Test regex support
@patterns=('\d\d\d', '\w\w\w', '[ABC][abc]', '[012][345]', '...', '[a-z][0-9]',
           '[aw-zX][123]', '[a-z]{5}', '0{80}', '[a-f][nprt]\d{3}',
           '\t\n\r\f\a\e');
for (@patterns)
{
    my $ret=$foo->randregex($_);
    if ($ret !~ /^$_$/)
    {
	$failed12++;
	print "'$_' failed, '$ret' does not match.\n" if ($ENV{VERBOSE});
    }
}
if ($failed12)
{
    print "not ";
    $failed++;
}
print "ok 12\n";

# 13: Test function interface to randregex()
if (String::Random::random_regex("[a][b][c]") ne "abc")
{
    print "not ";
    $failed++;
}
print "ok 13\n";

exit $failed;
