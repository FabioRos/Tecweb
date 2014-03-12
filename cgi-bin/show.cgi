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
my %in= ( 'type' => $type);
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




my $dom = XML::LibXML::Document->new( "1.0", "UTF-8");
my $ptrposts = $source->findnodes("/root/posts/".$vincolo);
my $radice = $parser->parse_balanced_chunk("<posts></posts>");
my $ptrradice = $radice->findnodes("posts")->get_node(1);
$dom->setDocumentElement($ptrradice);
my $ptrdompost =$dom->findnodes("/posts")->get_node(1);

#estraggo 4 post a seconda della pagina
for (my $var = $ptrposts->size()-(4*$pag); $var>$ptrposts->size()-(4*$pag)-4 && $ptrposts->size()> 1; $var--) {#nel caso che voglia vedere 4 articoli in una pagina
	my $ptrpost = $ptrposts->get_node($var);
	$ptrpost->setNodeName('post');
	$ptrdompost->addChild($ptrpost);
}


#individio l'autore del post
my $posts = $dom->findnodes("/posts/post");
foreach my $post ($posts->get_nodelist){
	my $ptridautor = $post->findnodes('idautore')->get_node(1);
	my $idautor = $ptridautor->textContent;
	my $ptrautor = $source->findnodes("/root/editori/editore[\@id='$idautor']")->get_node(1);
	my $newnodoautore = $ptrautor->cloneNode(1);
	$ptridautor->replaceNode($newnodoautore);
	my $ptridtags = $post->findnodes('tag');
	foreach my $ptridtag ($ptridtags->get_nodelist){
		my $idtag = $ptridtag->textContent;
		my $ptrtag = $source->findnodes("/root/tags/tag[\@id='$idtag']")->get_node(1);
		my $newnodotag = $ptrtag->cloneNode(1);
		$ptridtag->replaceNode($newnodotag);
	}
}





#stampo la pagina
print $page->header({-type=>'text/html', -charset=>'UTF-8'});
my $style_doc =XML::LibXML->load_xml(location=>$style_path);
my $stylesheet = $xslt->parse_stylesheet($style_doc);
my $results = $stylesheet->transform($dom,%in);
print $stylesheet->output_as_bytes($results);