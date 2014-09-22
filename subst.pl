#!/usr/bin/perl -T
use strict;
use warnings;
#use Data::Dumper;
use CGI;
my $q=CGI->new;
my ( @inp ) =$q->param('origtext') =~ /^([\w.-]*)$/;
my ( $table ) =$q->param('dict') =~ /^([\w.-]*)$/;
open TBL, '<:encoding(utf8)', "$table";
my @tbl=<TBL>;
our $word;
our @words;
my @chars;
my $ocnt=0;
print "Content-type: text/html\n\n";
print "<html><head><title>substituter</title></head><body>";
chomp (@inp);
foreach my $line (@inp){
  @words=split(/ /,$line);
  foreach $word (@words){
    foreach my $entry (@tbl){
      (my $key,my $str)=split(/\t/,$entry);
      if ($word eq $key){
        chomp($str);
        print($str." ");
      }
    }
  }
  print "\n";
}

