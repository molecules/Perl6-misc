#!/bin/env perl6

multi MAIN ($length=50, $count=32000000, $filetype='fastq')
{
    MAIN($filetype, $length, $count);
}

multi MAIN('fastq', $length, $count)
{
    my $fh = open "sample.$length.$count.fq", :w;
    $fh.say(("@$_", rand_seq($length), '+', rand_qual($length)).join("\n")) for ^$count;
}

multi MAIN('fasta', $length, $count)
{
    my $fh = open "sample.$length.$count.fa", :w;
    $fh.say(">$_\n" ~ rand_seq($length)) for ^$count;
}

sub rand_seq ( $length)
{
    return join("", roll($length,"ACGT".comb));
}

sub rand_qual ( $length)
{
    return join("", roll($length,"EFGHIJ".comb)); # All high quality
}
