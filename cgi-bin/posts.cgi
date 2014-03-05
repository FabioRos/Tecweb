#!/usr/bin/perl -w


use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use Lib::ErrorHandler;

my $query_string = $ENV{'QUERY_STRING'};
my($post, $idPost) = split( /=/, $query_string , 2);
my %in= ( $post => $idPost );

print ("Content-type: text/html\n\n");

my $xslt = XML::LibXSLT->new();
my $source = XML::LibXML->load_xml(location => "../data/XML/Posts.xml");
my $autorsList = XML::LibXML->load_xml(location => "../data/XML/Editori.xml");
my $pidautor = $source->findnodes("/posts/post[\@id='$idPost']/idAutore")->get_node(1);
my $idautor = $pidautor->textContent;
my $autorName = $autorsList->findnodes("/editori/editore[\@id='$idautor']/cognome")->get_node(1)->textContent;
#print ("<html><head></head><body><h1>$autorName</h1></body></html>");
#$pidautor->setData('ciao');

my $style_doc = XML::LibXML->load_xml(location=>"../data/XSLT/Posts.xsl",no_cdata=>1);
my $stylesheet = $xslt->parse_stylesheet($style_doc);
my $results = $stylesheet->transform($source, %in)||die("la trasformazione non è andata a termine");
print $stylesheet->output_as_bytes($results);