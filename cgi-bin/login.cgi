#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CFUN;

my $page = CGI->new();
my $parser = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();

my $DBpath = "../data/XML/Amministratori.xml";
my $source = XML::LibXML->load_xml(location => $DBpath);

my $username;
my $password;

if (defined $page->param('username')){
	$username = $page->param('username');
}
if (defined $page->param('password')){
	$password = $page->param('password');
}

my $ptradmins = $source->findnodes("/amministratori/admin");
my $found = 0;
my $ptruser;
for (my $var = 0; $var < $ptradmins->size() && !$found; $var++) {
	my $user = $ptradmins->get_node($var);
	my $name = $user->findnodes("username")->get_node(1)->textContent;
	if ($name eq $username){
		$ptruser=$user;
		$found=1;
	}
}

my $rdr;
if($found == 1){
	my $pass = $ptruser->findnodes("password")->get_node(1)->textContent;
	if($password eq $pass){
		my @attruser = $ptruser->findnodes("username")->get_node(1)->attributes();
		my $session = new CGI::Session();
		$session->param('id',@attruser[0]);
		$session->expire('+10m');
		$rdr ="../admin_news.html";
	}else{
		$rdr ="admin.cgi?err=password%20sbagliata";
	}
}else{
	$rdr ="admin.cgi?err=username%20sbagliato";
}

print $page->header({-type=>'text/html', -charset=>'UTF-8'});
print $page->start_html(
	-title => "Login - Music Break",
	-head => meta({-http_equiv => 'refresh',-content=> "0;url=$rdr"}),
	-dtd => ['-//W3C//DTD XHTML 1.0 Strict//EN','http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'],
	-lang => 'it'
	);

print $page->end_html;