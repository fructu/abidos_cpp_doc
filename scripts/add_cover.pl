#!/usr/bin/perl -w
#
# autor:Manuel Hevia
# description:
#  change links for http://htmlpreview.github.com/?
#
#-------------------------------------------
use strict;
use File::Copy;

#this is used like an global struct to store constans
my %hash_global = ();

sub process_html_file
{
  my $html_file   = shift;
  my $cover_file  = shift;

  my $cover_put   = 0;

  print "  file[$html_file]\n";

  open my $file, $html_file or die "Can't open $html_file for reading: $!";

  my $mode = (stat $html_file)[2] & 07777;

  open my $file_tmp, ">$html_file.tmp" or die "Can't open $html_file.tmp for writing: $!";

  while( my $line = <$file> )
  {
    if(0 == $cover_put)
    {
      #<th width="60%" align="center"> </th>
      if( $line =~ m/<body><div/ )
		  {
        $line =~ s/<body><div/<body><img src="$cover_file" alt="1" border="0" \/><div/;
        $cover_put = 1;
		  }
    }

    print $file_tmp $line;
  }

  close $file;
  close $file_tmp;

  move("$html_file.tmp", "$html_file");

  chmod($mode | 0600, "$html_file");
}

sub main
{
  my $num_args = $#ARGV;

  if ($num_args != 1) {
    print "\n need <html_file> <cover_file>\n\n";
    return;
  }

#  $hash_global{'prefix'} = 'http://htmlpreview.github.com/?https://github.com/fructu/abidos/blob/master/abidos_cpp_doc/user_manual/web_chunked/';
#  $hash_global{'prefix'} = "http://htmlpreview.github.com/?https://github.com/fructu/abidos/blob/master/$ARGV[0]/";
  my $html_file  = $ARGV[0];
  my $cover_file = $ARGV[1];

  print "change_links\n";
  my $result_total = 0;
  print "{\n";
  print " html_file  [$html_file]\n";
  print " cover_file [$cover_file]\n";
  process_html_file($html_file, $cover_file);
  print "}\n";
}

main();

