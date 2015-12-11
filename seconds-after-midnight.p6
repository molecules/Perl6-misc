#!/bin/env perl6

my $now             = DateTime.now;             # DateTime based on OS
my $midnight-today  = $now.truncated-to('day'); # Remove hour/minute/second

my $sec-after-midnight = $now.posix - $midnight-today.posix; # posix gives seconds since its epoch

$sec-after-midnight.say;
