#!/bin/env perl6

my $default_qual = 'E';

multi MAIN (
    $filename!,
    Int :$count      = 20000,
    Int :$length_min =    20,
    Int :$length_max =    30,
    Int :$seed       =  1234,
    Str :$out        = 'simulated_reads', # basename for output file and log
    Str :$three_prime_adapter,
)
{
    for ($length_min .. $length_max) -> $length
    {
        my $out_for_length = $out ~ "_$length";
        MAIN($filename, :$count, :$length, :$seed, :out($out_for_length), :$three_prime_adapter);
    }
    return;
}

multi MAIN (
    $filename!,
    Int :$count  = 20000,
    Int :$length =    21,
    Int :$seed   =  1234,
    Str :$out    = 'simulated_reads', # basename for output file and log
    Str :$three_prime_adapter,
)
{
    my $out_filename = "$out.fq";

    # set seed for the random number generator
    srand($seed);

    my $log = open "$out.log", :a;
    $log.say("#---------------------");
    $log.say("Source File\t$filename");
    $log.say("Output File\t$out_filename");
    $log.say("Seed\t$seed");
    $log.say("#---------------------");


    # Grab the first two lines from the reference file (assumes a single sequence fasta)
    my ($header, $sequence, $extra1, $extra2, $extra3) = $filename.IO.lines();
    die "Multiline FASTA files not currently supported"                     if (defined($extra1) && header_is_fasta($header));
    die "Currently only single sequence FASTA or FASTQ files are supported" if defined $extra3;
    die "Unrecognized format. Neither FASTA nor FASTQ"                      if ! ( header_is_fastq($header) || header_is_fasta($header));

    my $max_start_pos = $sequence.chars - $length;

    my $fh = open "$out.fq", :w;

    my @ids = (1 .. $count);

    # Calculate the length of the generated sequence plus the length of the adapter
    my $full_read_length = $length + $three_prime_adapter.chars;

    for @ids -> $sequence_ID
    {
        my $start           = $max_start_pos.rand();
        my $simulated_read  = $sequence.substr($start, $length);
        $fh.say( "@$sequence_ID\n$simulated_read$three_prime_adapter\n+");
        $fh.say( $default_qual x $full_read_length );
    }
    $fh.close;
}


multi MAIN (
    'no_adapter',
    $filename!,
    Int :$count  = 20000,
    Int :$length =    21,
    Int :$seed   =  1234,
    Str :$out    = 'simulated_reads', # basename for output file and log
)
{
    my $three_prime_adapter = "";
    my $out_filename = "$out.fq";

    # set seed for the random number generator
    srand($seed);

    my $log = open "$out.log", :a;
    $log.say("#---------------------");
    $log.say("Source File\t$filename");
    $log.say("Output File\t$out_filename");
    $log.say("Seed\t$seed");
    $log.say("#---------------------");


    # Grab the first two lines from the reference file (assumes a single sequence fasta)
    my ($header, $sequence, $extra1, $extra2, $extra3) = $filename.IO.lines();
    die "Multiline FASTA files not currently supported"                     if (defined($extra1) && header_is_fasta($header));
    die "Currently only single sequence FASTA or FASTQ files are supported" if defined $extra3;
    die "Unrecognized format. Neither FASTA nor FASTQ"                      if ! ( header_is_fastq($header) || header_is_fasta($header));

    my $max_start_pos = $sequence.chars - $length;

    my $fh = open "$out.fq", :w;

    my @ids = (1 .. $count);

    # Calculate the length of the generated sequence plus the length of the adapter
    my $full_read_length = $length + $three_prime_adapter.chars;

    for @ids -> $sequence_ID
    {
        my $start           = $max_start_pos.rand();
        my $simulated_read  = $sequence.substr($start, $length);
        $fh.say( "@$sequence_ID\n$simulated_read$three_prime_adapter\n+");
        $fh.say( $default_qual x $full_read_length );
    }
    $fh.close;
}
sub header_is_fasta ($header)
{
   return True if $header ~~ /^\>/; # header starts with 'greater than' symbol
}

sub header_is_fastq ($header)
{
   return True if $header ~~ /^\@/; # header starts with 'at' symbol
}
