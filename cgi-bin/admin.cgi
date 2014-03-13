#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;

my $page = CGI->new();

my $errmsg;
if (defined $page->param('err')){
	$errmsg=$page->param('err');
}


print $page->header({-type=>'text/html', -charset=>'UTF-8'});
print $page->start_html(
	-title => "Login - Music Break",
	-dtd => ['-//W3C//DTD XHTML 1.0 Strict//EN','http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'],
	-lang => 'it',
	-meta => {
		'author' => 'Fabio Ros, Valerio Burlin, Stefano Munari, Alberto Andeliero',
		'language' => 'italian it',
		'rating' => 'safe for kids',
		'keywords' => 'login, area riservata',
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
	{-class => 'login_box'},
	$page->h1('Pagina di <span xml:lang="eng">login</span>'),
	$page->h1("$errmsg"),
	$page->a({-class => 'help' , -href => '#sidebar'},'salta il contenuto')
	);
print $page->div(
	{-class => 'login_box'},
	start_form(
			-method =>'post',
			-action => 'login.cgi',
		),
	$page->fieldset(
			$page->label({-for => 'username'}, '<span xml:lang="en">Username: </span>'),
			$page->input({-type => 'text', -name => 'username' , -id => 'username'}),
			$page->label({-for => 'password'}, '<span xml:lang="en">Password: </span>'),
			$page->input({-type => 'text', -name => 'password' , -id => 'password'}),
			$page->input({-type => 'submit', -value => 'Accedi'})
		),
	endform
	);
print $page->div(
	{-id => 'footer'},
	$page->a({-class => 'help', -href => '#header'},'salta testo a fine pagina'),
	$page->p('&copy; 2014 Music Break All Right Reserved.')
	);

print $page->end_html;