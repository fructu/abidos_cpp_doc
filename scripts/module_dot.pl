#!/usr/bin/perl -w
#
# use Abidos to generate dot, svg, eps
#

use strict;

sub abidos
{
  my $file = shift;
  my $file_output = shift;  

  my $command = <<END;
	abidos --out_dir ../../abidos/processor/.abidos/ \\
		--loader ../../abidos/processor/.abidos/files_input \\
		--white_list $file \\
		--no_url
END

  print "command[$command]\n";
  system($command);

  $command= "cp ../../abidos/processor/.abidos/files_output.dot out/dot/$file_output.dot";
  system($command);

  $command= "cat out/dot/$file_output.dot | dot -Teps > out/images/$file_output.eps";
  system($command);

  $command= "cat out/dot/$file_output.dot | dot -Tsvg > out/images/$file_output.svg";
  system($command);
}

sub main
{
  my $file = shift;
  my $output_name = "";

  print "module_dot.pl\n";
  print "{\n";
  print "  file[$file]\n";

#[./chapter_architecture/c_loader_uml_01_white_list.txt]

  if( $file =~ m/.\/(chapter_[\S]+)_white_list.txt/)
  {
    $output_name = $1;
    $output_name =~ s/\//_/;

    abidos($file, $output_name);
  }

  print "}\n";  
}

main($ARGV[0]);
