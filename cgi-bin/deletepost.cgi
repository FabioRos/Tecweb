#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use Time::localtime;
use CFUN;

my $cgi = CGI->new();
my $xml = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();
my $DBpath = "../data/XML/DBsite.xml";
my $source = XML::LibXML->load_xml(location => $DBpath);


my $idutente=1;#CFUN::getsession();
if (defined $cgi->param('delete')) {
	CFUN::deletepost($cgi->param('delete'),$source);
	open(OUT,">$DBpath");
	print OUT $source->toString;
	close(OUT);
}


my $ptrposts = $source->findnodes("/root/posts//idautore[text()='$idutente']/..");

my $aux='';
foreach my $post ($ptrposts->get_nodelist){
	$aux = $aux . $cgi->div(
					{-class => 'article'},
					$cgi->h2( $cgi->a({-href => "deletepost.cgi?delete=".$post->findnodes("\@id")->get_node(1)->textContent},$post->findnodes("titolo")->get_node(1)->textContent)),
					$cgi->img(
						{-src => $post->findnodes("foto/src/node()")->get_node(1)->textContent, 
						-alt => $post->findnodes("foto/alt/node()")->get_node(1)->textContent})
				);
}


print $cgi->header({-type=>'text/html', -charset=>'UTF-8'});
print $cgi->start_html(
	-title => "Admin Delete posts - Music Break",
	-dtd => ['-//W3C//DTD XHTML 1.0 Strict//EN','http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'],
	-lang => 'it',
	-meta => {
		'author' => 'Fabio Ros, Valerio Burlin, Stefano Munari, Alberto Andeliero',
		'language' => 'italian it',
		'rating' => 'safe for kids',
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
	{ -id => 'contents'},
	$cgi->h1("Ricerca per il tag"),
	$cgi->a({-class => 'help', -href => '#footer'}, 'salta il contenuto'),
	$aux
	);

print CFUN::printfooter;
print $cgi->end_html;