# Perl6-misc
Some of my miscellaneous Perl 6 scripts »ö« 

## sbatch_run 

This is the Perl 6 script that I use more than any other.

Do you ever get tired of having to create your SLURM scripts by hand, even though most everything in them is the same, except for that one line command?

This script takes a job name and your command in quotes and then creates the script for you (and runs it for you).

    sbatch_run jobname 'ls'

WIll create the following script and run it for you:

    #!/bin/env bash
    #SBATCH -J jobname.sbatch
    #SBATCH -o jobname.sbatch.o_%j
    #SBATCH -e jobname.sbatch.e_%j
    #SBATCH --partition c14,general,HighMem
    #SBATCH --mem 5G
    #SBATCH --cpus-per-task 1
    #SBATCH --nodes 1
    #SBATCH --time 2-0

    ls
