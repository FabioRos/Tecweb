#!/usr/bin/perl -w


use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI;

my $page = CGI->new();
my $parser = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();

my $DBpath = "../data/XML/DBsite.xml";

my $idPost = $page->param('post');
my %in= ( 'post' => $idPost );





my $source = XML::LibXML->load_xml(location => $DBpath);

my $vincolo;
my $style_path;
my $posttype = substr($idPost, 0, 1);
if ("$posttype" eq 'e') {
	$style_path="../data/XSLT/Eventi.xsl";
	$vincolo = "eventi/evento";
}elsif ("$posttype" eq 'r') {
	$style_path="../data/XSLT/Recensioni.xsl";
	$vincolo = "recensioni/recensione";
}elsif ("$posttype" eq 'i'){
	$style_path="../data/XSLT/Interviste.xsl";
	$vincolo = "interviste/intervista";
}elsif ("$posttype" eq 'n'){
	$style_path="../data/XSLT/News.xsl";
	$vincolo = "news/item";
}


#individuo il post
my $ptrpost = $source->findnodes("/root/posts/".$vincolo."[\@id='$idPost']")->get_node(1);
$ptrpost->setNodeName('post');


#individio l'auto del post
my $ptridautor = $ptrpost->findnodes("idautore")->get_node(1);
my $idautor = $ptridautor->textContent;
my $ptrautor = $source->findnodes("/root/editori/editore[\@id='$idautor']")->get_node(1);
$ptridautor->replaceNode($ptrautor);


#individuo i tags che mi interessano
my $tags = $source->findnodes("/root/tags")->get_node(1);
my $ptridtags = $ptrpost->findnodes("tag");

foreach my $ptrtag ($ptridtags->get_nodelist){
	my $valtag = $ptrtag->textContent;
	my $tagname = $tags->findnodes("tag[\@id=$valtag]")->get_node(1);
	$ptrtag->replaceNode($tagname);
}

if ("$posttype" eq 'i'){
	my $ptridgallery = $ptrpost->findnodes("galleria")->get_node(1);
	my $idgallery = $ptridgallery->textContent;
	my $ptrgallery = $source->findnodes("/root/gallerie/galleria[\@id='$idgallery']")->get_node(1);
	$ptridgallery->replaceNode($ptrgallery);
}

#stampo la pagina
print $page->header({-type=>'text/html', -charset=>'UTF-8'});
my $style_doc =XML::LibXML->load_xml(location=>$style_path);
my $stylesheet = $xslt->parse_stylesheet($style_doc);
my $results = $stylesheet->transform($ptrpost, %in);
print $stylesheet->output_as_bytes($results);