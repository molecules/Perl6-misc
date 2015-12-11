#!/bin/env perl6

my %create_record = (
    fa => &fasta_record,
    fq => &fastq_record,
);

sub MAIN(:$filetype='fq', :$min=16, :$max=50, :$count=10)
{
    my $out_filename =  "sample.{$min}_to_{$max}_$count.$filetype";

    my $fh = open $out_filename, :w;
    my @range = $min .. $max;
    my $create_record = %create_record{$filetype};

    for ^$count
    {
        my $length = @range.roll;
        $fh.print($create_record($length, $_));
    }
}

sub rand_seq ( $length)
{
    return join("", roll($length,"ACGT".comb));
}

sub rand_qual ( $length)
{
    return join("", roll($length,"EFGHIJ".comb))
}

sub fasta_record ($length, $header)
{
    my $seq = rand_seq($length);
    return qq:to/END/;
        >$header
        $seq
        END
}

sub fastq_record ($length, $header)
{
    my $seq  = rand_seq($length);
    my $qual = rand_qual($length);

    return qq:to/END/;
        @$header
        $seq
        +
        $qual
        END
}
