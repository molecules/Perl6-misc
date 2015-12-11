#!/bin/env perl6
sub MAIN ( $filename )
{
    # Create file handles for forward and reverse reading frames
    my %fh_for = map { $_ => open("$filename.for.frame$_", :w) }, ^3; # ^3 means "up to 3" it is
    my %fh_rev = map { $_ => open("$filename.rev.frame$_", :w) }, ^3; #  the same as 0 .. 2

    # Read header and sequence one pair at a time
    for $filename.IO.lines() -> $header, $seq
    {
        # Create reverse complement
        my $rev_comp = $seq.trans("ACGT" => "TGCA").flip;

        # Print three reading frames for forward seq
        %fh_for{$_}.say("$header\n" ~ substr($seq,$_)) for 0 .. 2;

        # Print three reading frames for reverse compliment
        %fh_rev{$_}.say("$header\n" ~ substr($rev_comp,$_)) for 0 .. 2;
    }
}
