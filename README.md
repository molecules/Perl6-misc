# Perl6-misc
Some of my miscellaneous Perl 6 scripts »ö« 

## sbatch_run 

Do you ever get tired of having to create your SLURM scripts by hand, even though most everything in them is the same, except for that one-line command?

This script takes a job name and your command in quotes and then creates the script for you (and runs it for you).

    sbatch_run jobname 'ls -lArt > list_of_files.txt'

Will create the following script and run it for you:

    #!/bin/env bash
    #SBATCH -J jobname.sbatch
    #SBATCH -o jobname.sbatch.o_%j
    #SBATCH -e jobname.sbatch.e_%j
    #SBATCH --partition c14,general,HighMem
    #SBATCH --mem 5G
    #SBATCH --cpus-per-task 1
    #SBATCH --nodes 1
    #SBATCH --time 2-0

    ls -lArt > list_of_files.txt

## bsub_run 

Do you ever get tired of having to create your LSF/open-lava scripts by hand, even though most everything in them is the same, except for that one-line command?

This script takes a job name and your command in quotes and then creates the script for you (and runs it for you).

    bsub_run --job=list_files 'ls -lArt > list_of_files.txt'

Will create the following script and run it for you:

    #!/bin/env bash
    #BSUB -J list_files.bsub
    #BSUB -o list_files.bsub.o_%J
    #BSUB -e list_files.bsub.e_%J
    #BSUB -R "rusage[mem=5000] span[hosts=1]"
    #BSUB -n 1
    ls -lArt > list_of_files.txt
