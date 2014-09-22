#!/usr/bin/perl -T
require Encode;
binmode STDOUT, ":utf8";
binmode STDIN, ":utf8";
use strict;
use warnings;
#use Data::Dumper;
use CGI;
$ENV{'PATH'} = '.';
my $q=CGI->new;
my $table;
my ( $dst ) = $q->param( "dest" ) =~ /^([\w.-]*)$/;
my ( $src ) = $q->param("source") =~ /^([\w.-]*)$/;
my ( $mode ) = $q->param("mode") =~ /^([\w.-]*)$/;
if ($dst&&$src){$table=$src."2".$dst.".txt";
#print $table;
open TBL, '<:encoding(utf8)', "$table";}
my $out_char;
my @out_chars="";
my @tbl=<TBL>;
my @inp=$q->param('origtext');
my $icnt=0;
my $str;
my $key="";
#chomp (@inp);
print "Content-type: text/html; charset=utf-8\n\n";
print "<html><head><title>transliterator</title></head><body>";
print "<div style=color:white>";
print @inp;
print "</div>";
#print $table;
foreach my $word (@inp){
  my @chars=split(//,$word);
  foreach my $char (@chars){
    @out_chars="";
    $char=uc($char);
    $icnt=0;
    my $ocnt=0;
    foreach my $entry (@tbl){
      ($key,$str)=split(/\t/,$entry);
      chomp($str);
      if ($char eq $key){
        $out_chars[$ocnt++]=$str;
      }
      if ($char eq " "){@out_chars="";}
    }
    my $ccnt=$#out_chars+1;
    for ($ocnt=0;$ocnt<$ccnt;$ocnt++){
      if ($icnt>$ccnt){$icnt=0;}
      if ($mode eq "random"){
        $out_char=@out_chars[rand($#out_chars+1)];
      }else{
        $out_char=$out_chars[$icnt++];
      }
    }
  print $out_char;
  }
}
print "</body></html>";
