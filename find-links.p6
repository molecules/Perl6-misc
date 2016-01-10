#!/bin/env perl6
sub MAIN ( $dir-name = '.' )
{
    identify-links-in( $dir-name );
}

# recursively print all of the links in this directory structure
sub identify-links-in ( $dir-name )
{
    my @files = $dir-name.IO.dir();

    for @files -> $file
    {   
        if ( $file ~~ :l )
        {
            print "link: ";
            $file.Str.say;
        }
        elsif ($file ~~ :d )
        {
            identify-links-in( $file);
        }
    }   
}
