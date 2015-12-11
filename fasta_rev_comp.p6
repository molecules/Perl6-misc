#!/bin/env perl6
sub MAIN ( $filename )
{
    # Read header and sequence one pair at a time
    for $filename.IO.lines() -> $header, $seq
    {
        # Create reverse complement
        my $rev_comp = $seq.trans("ACGT" => "TGCA").flip;

        say "$header\n$rev_comp";
    }
}
