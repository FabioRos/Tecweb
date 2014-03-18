#!/usr/bin/perl -w


use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;

sub fetags{
	my $ptrtags = $_[0]->findnodes("tag");
	my $page = $_[1];
	my $aux = $page->div({-class => 'tag_title'}, 'Tag Articolo:');
	foreach my $tag ($ptrtags->get_nodelist){	
		$aux = $aux . $page->a(
			{
				-class =>'taglink',
				-tag => 'tag',
				-href => "searchtags.cgi?idtag=".$tag->findnodes("\@id")->get_node(1)->textContent
				},
				$tag->findnodes("node()")->get_node(1)->textContent
			);
		}
	return $aux;
}

sub feposts{
	my $ptrpos = $_[0]->findnodes("/posts/post");
	my $page = $_[1];
	my $aux;
	foreach my $post ($ptrpos->get_nodelist){
		$aux = $aux . $page->div(
				{-class => 'article'},
				$page->h2( $page->a({-href => "posts.cgi?post=".$post->findnodes("\@id")->get_node(1)->textContent},$post->findnodes("titolo")->get_node(1)->textContent)),
				$page->span(
					{-class => 'author'}, 
					"di ".$post->findnodes("editore/nome")->get_node(1)->textContent." ".$post->findnodes("editore/cognome")->get_node(1)->textContent." ".$post->findnodes("data")->get_node(1)->textContent
					),
				$page->img(
					{-src => $post->findnodes("foto/src/node()")->get_node(1)->textContent, 
					-alt => $post->findnodes("foto/alt/node()")->get_node(1)->textContent}),
				$page->p($post->findnodes("excerpt")->get_node(1)->textContent),
				$page->a(
					{-class => 'continua' , -href => "posts.cgi?post=".$post->findnodes("\@id")->get_node(1)->textContent},
					"continua →"
					),
				fetags($post,$page)
			);
	}
	return $aux;
}

sub fenav{
	my $type = $_[0];
	my $page = $_[1];
	my $aux;
	if ($type eq 'n'){
		$aux = $aux . $page->ul(
						li($page->a({-href => 'home.xml'}, '<span xml:lang="en">Home</span>')),
						li({-id => 'current_nav'}, $page->p('<span xml:lang="en">News</span>')),
						li([
						$page->a({-href => 'show.cgi?type=i'}, 'Interviste'),
						$page->a({-href => 'show.cgi?type=r'}, 'Recensioni'),
						$page->a({-href => 'show.cgi?type=e'}, 'Eventi')
					])
			);
	} elsif ($type eq 'i'){
		$aux = $aux . $page->ul(
						li([$page->a({-href => 'home.xml'}, '<span xml:lang="en">Home</span>'),
						$page->a({-href => 'show.cgi?type=n'}, '<span xml:lang="en">News</span>')]),
						li({-id => 'current_nav'},$page->p('Interviste')),
						li([
						$page->a({-href => 'show.cgi?type=r'}, 'Recensioni'),
						$page->a({-href => 'show.cgi?type=e'}, 'Eventi')])
			);
	} elsif ($type eq 'r'){
		$aux = $aux . $page->ul(
						li([$page->a({-href => 'home.xml'}, '<span xml:lang="en">Home</span>'),
						$page->a({-href => 'show.cgi?type=n'}, '<span xml:lang="en">News</span>'),
						$page->a({-href => 'show.cgi?type=i'}, 'Interviste')]),
						li({-id => 'current_nav'}, $page->p('Recensioni')),
						li($page->a({-href => 'show.cgi?type=e'}, 'Eventi'))
			);
	} elsif ($type eq 'e'){
		$aux = $aux . $page->ul(
						li([$page->a({-href => 'home.xml'}, '<span xml:lang="en">Home</span>'),
						$page->a({-href => 'show.cgi?type=n'}, '<span xml:lang="en">News</span>'),
						$page->a({-href => 'show.cgi?type=i'}, 'Interviste'),
						$page->a({-href => 'show.cgi?type=r'}, 'Recensioni')]),
						li({-id => 'current_nav'}, $page->p('Eventi'))
			);
	}
	return $aux;
}

sub fenavpag{
	my $pagina = $_[0]+1;
	my $type = $_[1];
	my $inizio = $_[2];
	my $fine = $_[3];
	my $page = $_[4];
	my $aux;
	if ($pagina > $inizio){
		$aux = $aux . $page->a({-href => "show.cgi?type=".$type."pag=".1},"<<");
		$aux = $aux . $page->a({-href => "show.cgi?type=".$type."pag=".$pagina-1},"<");
	}
	$aux = $aux . $page->a({-href => "show.cgi?type=".$type."pag=".$pagina},$pagina);
	if ($pagina < $fine){
		$aux = $aux . $page->a({-href => "show.cgi?type=".$type."pag=".$pagina+1},">");
		$aux = $aux . $page->a({-href => "show.cgi?type=".$type."pag=".$fine},">>");
	}
	return $aux;
}

my $page = CGI->new();
my $parser = XML::LibXML->new();
my $DBpath = "../data/XML/DBsite.xml";


my $type = $page->param('type');
my $pag = 1;
if (defined $page->param('pag')){
	$pag = $page->param('pag');
}
my %in= ( 'type' => $type);
$pag=$pag-1;

my $source = XML::LibXML->load_xml(location => $DBpath);

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
print $page->header({-type=>'text/html', -charset=>'UTF-8'});
print $page->start_html(
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
	{'media' => 'print','src' => '../public_html/css/print.css'},
	{'media' => 'speech','src' => '../public_html/css/aural.css'},
	{'media' => 'handheld, screen','src' => '../public_html/css/screen_login.css'}
	]
	);
print $page->div(
	{-id => 'header'},
	$page->a({-class => 'help' , -href => '#nav'}, 'salta intestazione'),
	$page->h1('<span xml:lang="eng">Music Break</span>'),
	$page->h2('Il portale di notizie dedicato alla musica')
	);

print $page->div(
	{-id => 'nav'},
	$page->a({-class => 'help', -href => '#contents'}, 'salta menù'),
	fenav($type,$page)
	);
print $page->div(
	{-id => 'contents'},
	$page->h1(uc($title)),
	$page->a({-class => 'help', -href => '#footer'}, 'salta il contenuto'),
	feposts($dom,$page)
	);
print $page->div(
	{-id => 'nav_pagine'},
	fenavpag($pag,$type,1,$end,$page)
	);
print $page->div(
	{-id => 'footer'},
	$page->a({-class => 'help', -href => '#header'},'salta testo a fine pagina'),
	$page->p('&copy; 2014 Music Break All Right Reserved.')
	);
print $page->end_html;