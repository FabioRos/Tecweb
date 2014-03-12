#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;

my $msg = $page->param('err');
my $page = CGI->new();

print $page->header({-type=>'text/html', -charset=>'UTF-8'});
