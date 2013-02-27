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

sub svg_extract_content
{
  my $svg_file = shift;
  my $content  = "";
  print "   svg_extract_content [$svg_file]\n";

  open(f_in,"< $svg_file")||die("error open < $svg_file");
  my @raw_data=<f_in>;

  $content  .= "\n<!-- extract of file[$svg_file] {\n";

  foreach my $l (@raw_data)
  {
    chomp($l);

    if($l =~ /\]\>/g )
    {
      $content  .= "]> -->\n";
    }
    else
    {
      $content  .= $l;
    }
    $content  .= "\n";
  }

  $content  .= "\n<!-- } extract of file[$svg_file] end-->\n";
  close(f_in);

  return $content;
}

sub process_html_file
{
  my $web_dir   = shift;
  my $file_name = shift;
  my $root_put  = 0;

  print "  file[$file_name]\n";

  open my $file, $file_name or die "Can't open $file_name for reading: $!";

  my $mode = (stat $file_name)[2] & 07777;

  open my $file_tmp, ">$file_name.tmp" or die "Can't open $file_name.tmp for writing: $!";

  while( my $line = <$file> )
  {
    if( $line =~ /href="http:([^"]*.html)"/g )
		{

		}
    elsif( $line =~ /href="([^"]*.html[\S]*)"/g )
		{
      print "   prefixing[$1]\n";
		  $line =~ s/href="([^"]*.html[\S]*)"/href="$hash_global{'prefix'}$1"/g;
		}

    #<img src="images/chapter_abidos_parsing_abidos_flow_diagram_01.svg" align="middle" alt="images/chapter_abidos_parsing_abidos_flow_diagram_01.svg" />
    if( $line =~ /<img src="([\S]*svg)" align="[\S]*" alt="[\S]*" \/>/g )
		{
		  my $svg_lines = svg_extract_content("$web_dir/$1");

      $line =~ s/<img src="[\S]*svg" align="[\S]*" alt="[\S]*" \/>/$svg_lines/g;
		}

    if(0 == $root_put)
    {
      #<th width="60%" align="center"> </th>
      if( $line =~ m/<th width="60%" align="center"> <\/th>/ )
		  {
        $line =~ s/<th width="60%" align="center"> <\/th>/<th width="60%" align="center"><a accesskey="r" href="https:\/\/github.com\/fructu\/abidos">github<\/a> <\/th>/;
        $root_put = 1
		  }
    }

    print $file_tmp $line;
  }

  close $file;
  close $file_tmp;

  move("$file_name.tmp", "$file_name");

  chmod($mode | 0600, "$file_name");
}

sub traverse_dir
{
  my $web_dir = shift;

	opendir(IMD, $web_dir) || die("Cannot open [$web_dir] directory");
	my @files= readdir(IMD);
	closedir(IMD);

	my @files_sorted = sort(@files);

	foreach my $f (@files)
	{
		unless ( ($f eq ".") || ($f eq "..") || ($f =~ /\.tmp$/) )
		{
      process_html_file($web_dir, "$web_dir/$f");
		}
	}
}

#"abidos_cpp_doc/user_manual/web_github_chunked_png"
# cd out/ \
#  perl ../../scripts/github_change_links.pl abidos_cpp_doc/programmer_manual/web_github_chunked_png web_github_chunked_png
#

sub main
{
  my $num_args = $#ARGV;

  if ($num_args != 1) {
    print "\n need <project_dir> <web_dir>\n\n";
    return;
  }

#  $hash_global{'prefix'} = 'http://htmlpreview.github.com/?https://github.com/fructu/abidos/blob/master/abidos_cpp_doc/user_manual/web_chunked/';
  $hash_global{'prefix'} = "http://htmlpreview.github.com/?https://github.com/fructu/abidos/blob/master/$ARGV[0]/";

  my $web_dir = $ARGV[1];

  print "change_links\n";
  my $result_total = 0;
  print "{\n";
  print " project_dir [$ARGV[0]]\n";
  print " web_dir     [$web_dir]\n"; #
  print " prefix      [$hash_global{'prefix'}]\n";
  traverse_dir($web_dir);
  print "}\n";
}

main();

