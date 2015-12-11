#!/bin/env perl6
sequence().say for 1 .. 10;

sub sequence {
   return "ACDEFGHIKLMNPQRSTVWY".comb.roll(20).join('');
}
