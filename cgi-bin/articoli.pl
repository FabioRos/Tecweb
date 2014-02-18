#!/usr/bin/perl -w
use strict;
use XML::LibXSLT;
use XML::LibXML;

my $query_string = $ENV{'QUERY_STRING'};
my($key, $value) = split( /=/, $query_string , 2);
my %in= ( $key => $value );

print ("Content-type: text/html\n\n");

my $xslt = XML::LibXSLT->new();
my $source = XML::LibXML->load_xml(location => "../data/articoli.xml");
my $style_doc = XML::LibXML->load_xml(location=>"../data/articoli.xsl",no_cdata=>1);
my $stylesheet = $xslt->parse_stylesheet($style_doc);
my $results = $stylesheet->transform($source, %in);
print $stylesheet->output_as_bytes($results);