#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use CGI;
my $q=CGI->new;
my @inp=$q->param('origtext');
my $weight=$q->param('weight');
if ($weight<.00001 or $weight>.99999){$weight=.5;}
my $word;
my $char;
my @words;
my @chars;
print "Content-type: text/html\n\n";
print "<html><head><title>scrambler</title></head><body>";
foreach my $line (@inp){
  @words=split(/ /,$line);
  foreach $word (@words){
    @chars=split(//,$word);
    my $acnt=0;
    my $lmt=$#chars-1;
    if ($lmt<3){print @chars;}else{
      foreach $char (@chars){
        if ($acnt==$lmt){}
        my $rnd=rand(1);
        if($acnt==0){$acnt++;}
        else{
          if ($rnd<$weight){
            my $tmp=$chars[++$acnt];
            $chars[$acnt]=$char;
            $chars[$acnt-1]=$tmp;
          }else{$acnt++;}
        }
        if ($acnt==$lmt){print @chars};
      }
    }
    print " ";
  }
}
print "</body></html>";

