#!/usr/bin/perl -w
#
# drop spaces from end of lines
#

use strict;
use File::Copy;

open my $file, $ARGV[0] or die "Can't open $ARGV[0] for reading: $!";

my $mode = (stat $ARGV[0])[2] & 07777;

open my $file_tmp, ">$ARGV[0].tmp" or die "Can't open $ARGV[0].tmp for writing: $!";

while( my $line = <$file> )
{
    $line =~ s/\s+$/\n/g;
    print $file_tmp $line;
}

close $file;
close $file_tmp;

move("$ARGV[0].tmp", "$ARGV[0]");

chmod($mode | 0600, "$ARGV[0]");

