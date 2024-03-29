#!/usr/bin/perl

use strict;
use warnings;

use Log::Log4perl;
# do some setup here...honest guv

use Test::More tests => 2;
use Test::Builder::Tester;
use Test::Log4perl;
use Test::Exception;

my $logger   = Log::Log4perl->get_logger("Foo");
my $tlogger  = Test::Log4perl->get_logger("Foo");

########################################################

test_out("ok 1 - Log4perl test");

Test::Log4perl->start();
$tlogger->error(qr/hair/);
$logger->error("my hair is on fire!");
Test::Log4perl->end();

test_test("basic qr test");

########################################################

test_out("not ok 1 - Log4perl test");
test_fail(+9);
test_diag("1st message logged wasn't what we expected:");
test_diag("  message was 'my hair is on fire!'");
test_diag("     not like '(?-xism:tree)'");
test_diag(" (Offending log call from line ".(__LINE__+4)." in ".filename().")");

Test::Log4perl->start();
$tlogger->error(qr/tree/);
$logger->error("my hair is on fire!");
Test::Log4perl->end();

test_test("getting wrong message");

########################################################

sub filename
{
  return (caller)[1];
}
