#!/usr/bin/perl -w
#
#
#
#


use strict;

sub abidos
{
  my $file = shift;
  my $file_output = shift;
  my $command = "";

  print "  file_output[$file_output.svg]\n";
  $command= "  cat $file | dot -Tsvg > out/dot_images/$file_output.svg";
  system($command);

  print "  file_output[$file_output.eps]\n";
  $command= "  cat $file | dot -Teps > out/dot_images/$file_output.eps";
  system($command);

  print "  file_output[$file_output.png]\n";
  $command= "  cat $file | dot -Tpng > out/dot_images/$file_output.png";
  system($command);
}

sub main
{
  my $file = shift;
  my $output_name = "";

  print "images_dot.pl\n";
  print "{\n";
  print "  file[$file]\n";


  if( $file =~ /\.\/([\S]*).(gv|dot)/)
  {
    $output_name = $1;
    $output_name =~ s/\//_/g;

    abidos($file, $output_name);
  }

  print "}\n";
}

main($ARGV[0]);
