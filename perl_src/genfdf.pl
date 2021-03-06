#!/usr/bin/env perl -w
use strict;
use warnings;
#use encoding 'utf8';
#use encoding 'cp1251';
use PDF::FDF::Simple;
use Getopt::Std;

our $opt_o;
getopts("o:");
my $outfile = $opt_o || "-";
my %content = ();
our $fields;

foreach my $file (@ARGV){
  open(IN,"$file") 
		or die ("could not open $file");
  undef($/);
  my $in = <IN>;
  eval($in);
  die "reading input failed: $@" if $@;
  %content=(%content, %$fields);
}


my $f=new PDF::FDF::Simple({
			    filename => $outfile,
			    content => \%content });

$f->save;
