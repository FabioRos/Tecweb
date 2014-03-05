#!/usr/bin/perl -w


use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use Lib::ErrorHandler;

my $DBpath = "../data/XML/all-in-one.xml";

my $query_string = $ENV{'QUERY_STRING'};
my($post, $idPost) = split( /=/, $query_string , 2);
my %in= ( $post => $idPost );



my $parser = XML::LibXML->new();

my $source = XML::LibXML->load_xml(location => $DBpath);

my $posttype = substr($idPost, 0, 1);
if ($posttype=="e") {
	my $style_path="../data/XSLT/Eventi.xsl";
	my $vicolo = "eventi/evento";
}else if ($posttype == "r") {
	my $style_path="../data/XSLT/Recensioni.xsl";
	my $vicolo = "recensioni/recensione";
}else if ($posttype == "i"){
	my $style_path="../data/XSLT/Interviste.xsl";
	my $vicolo = "interviste/intervista";
}else if ($posttype == "n"){
	my $style_path="../data/XSLT/News.xsl";
	my $vicolo = "news/item";
}


#individuo il post
my $ptrpost = $source->findnodes("/root/posts/".$vincolo."[\@id='$idPost']")->get_node(1);
$ptrpost->setNodeName("post");


#individio l'auto del post
my $ptridautor = $ptrpost->findnodes("idautore")->get_node(1);
my $idautor = $ptridautor->textContent;
my $ptrautor = $source->findnodes("/root/editori/editore[\@id='$idautor']")->get_node(1);
$ptridautor->replaceNode($ptrautor);


#individuo i tags che mi interessano
my $tags = $source->findnodes("/root/tags")->get_node(1);
my $ptridtags = $ptrpost->findnodes("tag");

for (my $var = 1; $var < ptridtags.size()+1; $var++){
	my $ptrtag = $ptridtags->get_node($var);
	my $valtag = $ptrtag->textContent;
	my $tagname = $tags->findnodes("tag[\@id=$valtag]")->get_node(1);
	$ptrtag->replaceNode($tagname);
}


#estrapolo il path dell'immagine principale e inserisco il codice html
my $ptrimg = $ptrpost->findnodes("foto")->get_node(1);
my $imgpath = $ptrimg->textContent;
my $descrizione = $ptrpost->findnodes("altfoto")->get_node(1)->textContent;
my $imgtagtext = "<img src=\"$imgpath\" alt=\"$descrizione\"/>";#aggiungere alt dal tag altfoto
my $imgtag = $parser->parse_balanced_chunk("<foto>$imgtagtext</foto>");
$ptrimg->replaceNode($imgtag);



print ("Content-type: text/html\n\n");
#scrivo l'header della pagina


#trasformazione di stile solo per il body
my $style_doc =XML::LibXML->load_xml(location=>$style_path);
my $xslt = XML::LibXSLT->new();
my $stylesheet = $xslt->parse_stylesheet($style_doc);
my $results = $stylesheet->transform($ptrpost, %in)||die("la trasformazione non è andata a termine");
print $stylesheet->output_as_bytes($results);