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

  open my $file, $file_name or die "Can't open $file_name for reading: $!";

  my $mode = (stat $file_name)[2] & 07777;

  open my $file_tmp, ">$file_name.tmp" or die "Can't open $file_name.tmp for writing: $!";

  while( my $line = <$file> )
  {
    if( $line =~ /label\=\"\{ c_parser_descent\|/ ) {
      printf "  cuting class [c_parser_descent] \n";
      $line =~ s/\\l\+ c_parser_descent\(\)/\$\\l\+ c_parser_descent\(\)/g;
      $line =~ s/\\l\- int preprocessor_include([^\$]+)\$\\l\+ c_parser_descent\(\)/\\l\/*A LOT OF SYNTACTIC RULES ARE HERE ...*\/\\l\+ c_parser_descent\(\)/g;
    }

    print $file_tmp $line;
  }

  close $file;
  close $file_tmp;

  move("$file_name.tmp", "$file_name");

  chmod($mode | 0600, "$file_name");
}

sub abidos
{
  my $file = shift;
  my $file_output = shift;

  my $command = <<END;
	abidos --out_dir ../../abidos_cpp/processor/.abidos_cpp/ \\
		--loader ../../abidos_cpp/processor/.abidos_cpp/files_input \\
		--white_list $file \\
		--no_url
END

  print "command[$command]\n";
  system($command);

  $command= "cp ../../abidos_cpp/processor/.abidos_cpp/files_output.dot out/dot/$file_output.dot";
  system($command);

  special_process("out/dot/$file_output.dot");

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
