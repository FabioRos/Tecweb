#!/usr/bin/perl -w


use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use Lib::ErrorHandler;

my $query_string = $ENV{'QUERY_STRING'};
my($nome, $tag) = split( /=/, $query_string , 2);