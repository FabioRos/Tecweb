#!/usr/bin/perl -w


use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use Lib::ErrorHandler;

#nella query troviamo per esmpio ..cgi-bin/show.cgi?type=e&pag=1

my $query_string = $ENV{'QUERY_STRING'};
my @pairs = split( /&/, $query_string , 2);
my ($nome , $type) = @pairs[0];
my ($pagina , $pag) = @pairs[1];


my $parser = XML::LibXML->new();
my $DBpath = "../data/XML/all-in-one.xml";
my $source = XML::LibXML->load_xml(location => $DBpath);


my $posttype = substr($type, 0, 1);
if ($posttype=="e") {
	my $vicolo = "eventi/evento";
}else if ($posttype == "r") {
	my $vicolo = "recensioni/recensione";
}else if ($posttype == "i"){
	my $vicolo = "interviste/intervista";
}else if ($posttype == "n"){
	my $vicolo = "news/item";
}
my $ptrposts = $source->findnodes("/root/posts/".$vincolo);
my $radice = $parser->parse_balanced_chunk("<posts></posts>");
for (my $var = $ptrposts.size()-(4*$pag); $var>$ptrposts.size()-(4*$pag)-4; $var--) {#nel caso che voglia vedere 4 articoli in una pagina
	$ptrpost = $ptrposts->get_node($var);
	$ptrpost->setNodeName("post");
	$radice->appendChild($ptrpost);
}








print ("Content-type: text/html\n\n");

