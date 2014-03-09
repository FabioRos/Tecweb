#!/usr/bin/perl -w


use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI/:standard/;

my $page = CGI->new();
my $parser = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();

my $DBpath = "../data/XML/DBsite.xml";

my $type = $page->param('type');
my $pag = 1;
if (defined $page->param('pag')){
	$pag = $page->param('pag');
}

print ("$pag");

#my $source = XML::LibXML->load_xml(location => $DBpath);


#my $posttype = substr($type, 0, 1);
#if ($posttype=="e") {
#	my $vicolo = "eventi/evento";
#}elsif ($posttype == "r") {
#	my $vicolo = "recensioni/recensione";
#}elsif ($posttype == "i"){
#	my $vicolo = "interviste/intervista";
#}elsif ($posttype == "n"){
#	my $vicolo = "news/item";
#}
#my $ptrpost = $source->findnodes("/root/posts/".$vincolo);
#my $radice = $parser->parse_balanced_chunk("<posts></posts>");
#for (my $var = $ptrposts.size()-(4*$pag); $var>$ptrposts.size()-(4*$pag)-4; $var--) {#nel caso che voglia vedere 4 articoli in una pagina
#	$ptrpost = $ptrposts->get_node($var);
#	$ptrpost->setNodeName("post");
#	$radice->appendChild($ptrpost);
#}








#print ("Content-type: text/html\n\n");

