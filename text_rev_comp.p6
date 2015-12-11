#!/bin/env perl6
# This processes a file in which each line is a nucleotide sequence (i.e. no headers, qualities, etc)
sub MAIN ( $filename )
{
    # Process each sequence
    for $filename.IO.lines() -> $seq
    {
        # Create reverse complement
        my $rev_comp = $seq.trans("ACGT" => "TGCA").flip;

        say $rev_comp;
    }
}
