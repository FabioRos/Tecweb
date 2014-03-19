#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

my $query_string = $ENV{'QUERY_STRING'};
my($nome, $tag) = split( /=/, $query_string , 2);