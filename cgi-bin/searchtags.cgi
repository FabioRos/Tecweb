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
my $xml = XML::LibXML->new();
my $DBpath = "../data/XML/DBsite.xml";
my $source = XML::LibXML->load_xml(location => $DBpath);


my $tag;
if (defined $cgi->param('tag')){
	my $str = $cgi->param('tag');
	$tag = CFUN::searchidtag($str,$source);
}
if (defined $cgi->param('idtag')) {
	$tag=$cgi->param('idtag');
}

my $ptrposts = $source->findnodes("/root/posts//tag[text()='$tag']/..");

my $aux='';
foreach my $post ($ptrposts->get_nodelist){
	$aux = $aux . $cgi->div(
					{-class => 'article'},
					$cgi->h2( $cgi->a({-href => "posts.cgi?post=".$post->findnodes("\@id")->get_node(1)->textContent},$post->findnodes("titolo")->get_node(1)->textContent)),
					$cgi->img(
						{-src => $post->findnodes("foto/src/node()")->get_node(1)->textContent, 
						-alt => $post->findnodes("foto/alt/node()")->get_node(1)->textContent})
				);
}


print $cgi->header({-type=>'text/html', -charset=>'UTF-8'});
print $cgi->start_html(
	-title => "Ricerca per tag - Music Break",
	-dtd => ['-//W3C//DTD XHTML 1.0 Strict//EN','http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'],
	-lang => 'it',
	-meta => {
		'author' => 'Fabio Ros, Valerio Burlin, Stefano Munari, Alberto Andeliero',
		'language' => 'italian it',
		'rating' => 'safe for kids',
		'keywords' => 'ricerca tags',
		'robots' => 'noindex,nofollow'
	},
	-style => [
		{'media' => 'print','src' => '/css/print.css'},
		{'media' => 'speech','src' => '/css/aural.css'},
		{'media' => 'handheld, screen','src' => '/css/screen.css'}
		]
	);
print $cgi->div(
	{ -id => 'contents'},
	$cgi->h1("Ricerca per il tag"),
	$cgi->a({-class => 'help', -href => '#footer'}, 'salta il contenuto'),
	$aux
	);
print CFUN::printfooter;
print $cgi->end_html;