#!/usr/bin/perl -w
#
# Fructu 2013
# v0.1
#
# abidos
#  - upload pdfs to google.code
#  - put the new versions in abidos/README
#  - push the changes in abidos
#
# delete links:
#  https://code.google.com/p/abidos-cpp/downloads/delete?name=abidos_cpp_programmer_manual_draft_0.02.pdf
#  https://code.google.com/p/abidos-cpp/downloads/delete?name=abidos_cpp_user_manual_draft_0.02.pdf
#
# v0.2
#    i use github to store pdfs and not google code
#
#

use strict;
use File::Copy;

my %hash_global = {};

sub rename_change
{
  my $file_name = shift;
  my $version = shift;
  my $manual_type = shift;

  open my $file, $file_name or die "Can't open $file_name for reading: $!";

  my $mode = (stat $file_name)[2] & 07777;

  open my $file_tmp, ">$file_name.tmp" or die "Can't open $file_name.tmp for writing: $!";

  while( my $line = <$file> )
  {
    if( $line =~ /\*\* $manual_type manual pdf:/ ) {
#      $line = "** ${manual_type} manual pdf: http://abidos-cpp.googlecode.com/files/abidos_cpp_${manual_type}_manual_${version}.pdf\n";
#    $line = "** ${manual_type} manual pdf: https://github.com/fructu/abidos/tree/master/abidos_cpp_doc/${manual_type}_manual/pdf/abidos_cpp_${manual_type}_manual_${version}.pdf\n";

    $line = "** ${manual_type} manual pdf: https://github.com/fructu/abidos/raw/master/abidos_cpp_doc/${manual_type}_manual/pdf/abidos_cpp_${manual_type}_manual_${version}.pdf[abidos_cpp_${manual_type}_manual_${version}.pdf]\n";

#    $line = "** ${manual_type} manual pdf: http://htmlpreview.github.com/?https://github.com/fructu/abidos/blob/master/abidos_cpp_doc/${manual_type}_manual/pdf/abidos_cpp_${manual_type}_manual_${version}.pdf\n";
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
    chomp($line);
    $version = $line;
  }

  close $file;
  return $version;
}

sub upload_code_google
{
  my $version = shift;
  my $manual_type = shift;

  my $command = "curl https://code.google.com/p/abidos-cpp/downloads/delete.do?name=abidos_cpp_${manual_type}_manual_${version}.pdf";
  print "    command[$command]\n";
#  system($command) == 0 or die "failed uploading";

  $command = <<END;
python scripts/googlecode_upload.py \\
    --user=$hash_global{'user'} \\
    --password=$hash_global{'pass'} \\
    --summary=manual \\
    --project=abidos-cpp ${manual_type}_manual/out/pdf/abidos_cpp_${manual_type}_manual_${version}.pdf
END

  print "    command[$command]\n";
  system($command) == 0 or die "failed uploading";
}

sub cp_pdf
{
  my $version = shift;
  my $manual_type = shift;

  my $command = "mkdir -p ../abidos/abidos_cpp_doc/${manual_type}_manual/pdf";
  print "    command[$command]\n";

  system($command) == 0 or print "../abidos/abidos_cpp_doc/${manual_type}_manual/pdf";

  $command = "cp ${manual_type}_manual/out/pdf/abidos_cpp_${manual_type}_manual_${version}.pdf ../abidos/abidos_cpp_doc/${manual_type}_manual/pdf";
  print "    command[$command]\n";

  system($command) == 0 or die "failed coping ${manual_type} manual";
}

sub abidos_generate_doc
{
  my $command = <<END;
 cd linux_man/ ;\\
 make clean; \\
 make
 cd ..
 cp -a linux_man/out/abidos_cpp.1.html ../abidos/abidos_cpp_doc/linux_man/ 
END

  print "    command[$command]\n";
  system($command) == 0 or die "failed generating man";

  $command = <<END;
 cd user_manual/ ;\\
 make clean; \\
 make
 cd ..
 cp -av user_manual/out/web_github_chunked_png/* \\
    ../abidos/abidos_cpp_doc/user_manual/web_github_chunked_png
 cp -av user_manual/out/web_github_chunked_svg/* \\
    ../abidos/abidos_cpp_doc/user_manual/web_github_chunked_svg
END

  print "    command[$command]\n";
  system($command) == 0 or die "failed generating user manual";

  $command = <<END;
 cd programmer_manual/ ;\\
 make clean; \\
 make
 cd .. 
 cp -av programmer_manual/out/web_github_chunked_png/* \\
       ../abidos/abidos_cpp_doc/programmer_manual/web_github_chunked_png
 cp -av programmer_manual/out/web_github_chunked_svg/* \\
       ../abidos/abidos_cpp_doc/programmer_manual/web_github_chunked_svg
END

  print "    command[$command]\n";
  system($command) == 0 or die "failed generating programmer manual";
}

sub abidos_delete_pdfs
{
  my $version = shift;

  my $command = <<END;
    cd  ../abidos; \\
    git rm  abidos_cpp_doc/user_manual/pdf ; \\
    git rm  abidos_cpp_doc/programmer_manual/pdf
END

  print "    command[$command]\n";
  system($command) == 0 or print "git failed rm\n";
}


sub abidos_push
{
  my $version = shift;

  my $command = <<END;
    cd  ../abidos; \\
    git add abidos_cpp_doc/linux_man/*;\\
    git add abidos_cpp_doc/user_manual/web_github_chunked_svg/*;\\
    git add abidos_cpp_doc/user_manual/web_github_chunked_png/*;\\    
    git add abidos_cpp_doc/programmer_manual/web_github_chunked_svg/*;\\
    git add abidos_cpp_doc/programmer_manual/web_github_chunked_png/*;\\
    git add -u; \\
    git add  abidos_cpp_doc/user_manual/pdf/* ; \\
    git add  abidos_cpp_doc/programmer_manual/pdf/* ; \\
    git commit -m "robot push ${version}"; \\
    git push
END

  print "    command[$command]\n";
  system($command) == 0 or die "git failed";
}

sub get_user_pass
{
  my $file_name = "$ENV{'HOME'}/.netrc";

  open my $file, $file_name or die "Can't open $file_name for reading: $!";
  while( my $line = <$file> )
  {
    chomp($line);

    if($line =~ /login ([\w\d]*)@/)
    {
      $hash_global{'user'} = $1;
    }

    if($line =~ /password ([\w]*)/)
    {
      $hash_global{'pass'} = $1;
    } 

    print "user[$hash_global{'user'}] pass[$hash_global{'pass'}]\n";
  }

  close $file;
}

sub main
{
  my $file_name = "../abidos/README.asciidoc";
  my $output_name = "";
  my $version = "";  

  print "deploy.pl\n";
  print "{\n";
  print "  file[$file_name]\n";

  abidos_generate_doc();

# used to upload to google code
#  get_user_pass();

  abidos_delete_pdfs();

  print "coping pdf files\n";
  $version = version_extract("user_manual/out/version.tmp");
  cp_pdf($version, "user");
#  upload_code_google($version, "user");
  rename_change($file_name, $version, "user");

  $version = version_extract("programmer_manual/out/version.tmp");
  cp_pdf($version, "programmer");
#  upload_code_google($version, "programmer");
  rename_change($file_name, $version, "programmer");

  abidos_push($version);

  print "}\n";
}

main();

