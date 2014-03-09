#!/usr/bin/perl -w


use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;

my $page = CGI->new();
my $parser = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();

my $DBpath = "../data/XML/DBsite.xml";

my $type = $page->param('type');
my $pag = 1;
if (defined $page->param('pag')){
	$pag = $page->param('pag');
}
$pag=$pag-1;

my $source = XML::LibXML->load_xml(location => $DBpath);
my $style_path="../data/XSLT/Show.xsl";


my $posttype = substr($type, 0, 1);
my $vincolo;
if ($posttype eq "e") {
	$vincolo = "eventi/evento";
}elsif ($posttype eq "r") {
	$vincolo = "recensioni/recensione";
}elsif ($posttype eq "i"){
	$vincolo = "interviste/intervista";
}elsif ($posttype eq "n"){
	$vincolo = "news/item";
}

#estraggo 4 post a seconda della pagina
my $ptrposts = $source->findnodes("/root/posts/".$vincolo);
my $radice = $parser->parse_balanced_chunk("<posts></posts>");
for (my $var = $ptrposts->size()-(4*$pag); $var>$ptrposts->size()-(4*$pag)-4; $var--) {#nel caso che voglia vedere 4 articoli in una pagina
	my $ptrpost = $ptrposts->get_node($var);
	

	#individio l'autore del post
	my $ptridautor = $ptrpost->findnodes('idautore')->get_node(1);
	my $idautor = $ptridautor->textContent;
	my $ptrautor = $source->findnodes("/root/editori/editore[\@id='$idautor']")->get_node(1);
	$ptridautor->replaceNode($ptrautor);

	$ptrpost->setNodeName('post');
	$radice->addChild($ptrpost);
}



#stampo la pagina
print $page->header({-type=>'text/html', -charset=>'UTF-8'});
my $style_doc =XML::LibXML->load_xml(location=>$style_path);
my $stylesheet = $xslt->parse_stylesheet($style_doc);
my $results = $stylesheet->transform($radice);
print $stylesheet->output_as_bytes($radice);