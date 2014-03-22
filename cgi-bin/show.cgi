#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CFUN;


my $cgi = CGI->new();
my $parser = XML::LibXML->new();
my $DBpath = "../data/XML/DBsite.xml";
my $source = XML::LibXML->load_xml(location => $DBpath);

my $type = $cgi->param('type');
my $pag = 1;
if (defined $cgi->param('pag')){
	$pag = $cgi->param('pag');
}
my %in= ( 'type' => $type);
$pag=$pag-1;



my $posttype = substr($type, 0, 1);
my $title;
my $vincolo;
if ($posttype eq "e") {
	$vincolo = "eventi/evento";
	$title = "Eventi";
}elsif ($posttype eq "r") {
	$vincolo = "recensioni/recensione";
	$title = "Recensioni";
}elsif ($posttype eq "i"){
	$vincolo = "interviste/intervista";
	$title = "Intervista";
}elsif ($posttype eq "n"){
	$vincolo = "news/item";
	$title = "News";
}

my $dom = XML::LibXML::Document->new( "1.0", "UTF-8");
my $ptrposts = $source->findnodes("/root/posts/".$vincolo);
my $radice = $parser->parse_balanced_chunk("<posts></posts>","UTF-8");
my $ptrradice = $radice->findnodes("posts")->get_node(1);
$dom->setDocumentElement($ptrradice,'UTF-8');
my $ptrdompost =$dom->findnodes("/posts")->get_node(1);

#$ptrposts->size()-
#estraggo 4 post a seconda della pagina
for (my $var = 1; $var<5; $var++) {#nel caso che voglia vedere 4 articoli in una pagina
	my $ptrpost = $ptrposts->get_node($var);
	$ptrpost->setNodeName('post');
	$ptrdompost->addChild($ptrpost);
}


#individio l'autore del post
my $posts = $dom->findnodes("/posts/post");
my $end=$posts->size()/4;
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
print $cgi->header({-type=>'text/html', -charset=>'UTF-8'});
print $cgi->start_html(
	-title => "$title - Music Break",
	-dtd => ['-//W3C//DTD XHTML 1.0 Strict//EN','http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'],
	-lang => 'it',
	-meta => {
		'author' => 'Fabio Ros, Valerio Burlin, Stefano Munari, Alberto Andeliero',
		'language' => 'italian it',
		'rating' => 'safe for kids',
		'keywords' => "$title",
		'robots' => 'noindex,nofollow'
	},
	-style => [
	{'media' => 'print','src' => '/css/print.css'},
	{'media' => 'speech','src' => '/css/aural.css'},
	{'media' => 'handheld, screen','src' => '/css/screen.css'}
	]
	);
print $cgi->div(
	{ -id => 'header'},
	$cgi->a({-class => 'help' , -href => '#nav'}, 'salta intestazione'),
	$cgi->div({-id => 'title'},
		$cgi->span({-id => 'logo', -class => 'notAural'}, $cgi->img({-src => '/img/tazza-di-caffe.jpg', -alt => 'Tazza di caffè fumante in cui viene immersa  una pausa di semiminima'})),
		$cgi->h1('<span xml:lang="en">Music Break</span>'),
		$cgi->h2('Il portale di notizie dedicato alla musica')
	)
	);

print $cgi->div(
	{-id => 'nav'},
	$cgi->a({-class => 'help', -href => '#search'}, 'salta menù'),
	CFUN::fenav($type),
	$cgi->div(
			{-id=>'search'},
			$cgi->a({ -class => 'help' , -href => '#contents'}, 'salta barra di ricerca'),
			$cgi->input({
				-type => 'text', 
				-id => 'text_field', 
				-onclick => 'searchbar();', 
				-onblur => 'defsearch();', 
				-name => 'query'},
				'Cerca...'),
			$cgi->input({-type=>'submit', -id=>'button', -alt=>'inserire una ricerca', -value=>'Cerca'}),
			$cgi->input({-type=>'hidden', -value=>'Home.html', -name=>'sitesearch'})
		)
	);
print $cgi->div(
	{-id => 'contents'},
	$cgi->h1($title),
	$cgi->a({-class => 'help', -href => '#nav_pagine'}, 'salta il contenuto'),
	CFUN::feposts($dom,$type)
	);
print $cgi->div(
	{-id => 'nav_pagine'},
	CFUN::fenavpag($pag,$type,1,$end,$cgi)
	);
print $cgi->div(
	{-id => 'footer'},
	$cgi->a({-class => 'help', -href => '#header'},'salta testo a fine pagina'),
	$cgi->p('&#169; 2014 <span xml:lang="en">Music Break All Right Reserved</span>. | ',
		$cgi->a({-href=>'/info.html'},'Chi siamo'),' | ',
		$cgi->a({-href=>'/condizioni.html'},'Condizioni d\'uso'),' | ',
		$cgi->a({-href=>'/contact.html'},'Contatti')
		)
	);
print $cgi->end_html;