#!/usr/bin/perl -w
#
# use Abidos to generate dot, svg, eps
# for now uses <file>_white_list.txt

use strict;
use File::Copy;

#
# here i cut some method or atribues in order to do more compact diagrams.
#
sub special_process
{
  my $file_name = shift;
  my $version = shift;

  open my $file, $file_name or die "Can't open $file_name for reading: $!";

  my $mode = (stat $file_name)[2] & 07777;

  open my $file_tmp, ">$file_name.tmp" or die "Can't open $file_name.tmp for writing: $!";

  while( my $line = <$file> )
  {
    if( $line =~ /\$VERSION/ ) {
      $line =~ s/\$VERSION/$version/g;
    }

    print $file_tmp $line;
  }

  close $file;
  close $file_tmp;

  move("$file_name.tmp", "$file_name");

  chmod($mode | 0600, "$file_name");
}

sub version_extract
{
  my $file_name = shift;
  my $version = "";

  open my $file, $file_name or die "Can't open $file_name for reading: $!";
  while( my $line = <$file> )
  {
    #V_Draft_0.0.02, November 2012:
    if( $line =~ m/V_([^,]*)/)
    {
      $version = $1;
    }
  }

  close $file;
  return $version;
}

sub main
{
  my $file_name = shift;
  my $output_name = "";
  my $version = "";  

  print "module_dot.pl\n";
  print "{\n";
  print "  file[$file_name]\n";
  $version = version_extract($file_name);
  special_process("out/cover/cover.html", $version);

  my $command = "echo '$version' > out/version.tmp";
  print "command[$command]\n";
  system($command);

  print "}\n";
}

main($ARGV[0]);
