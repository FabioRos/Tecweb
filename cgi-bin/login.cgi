#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;

my $page = CGI->new();
my $parser = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();

my $DBpath = "../data/XML/Amministratori.xml";
my $source = XML::LibXML->load_xml(location => $DBpath);

my $username = $page->param('username');
my $password = $page->param('password');



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

if($found == 1){
	my $pass = $ptruser->findnodes("password")->get_node(1)->textContent;
	if($password eq $pass){
		my $named = $ptruser->findnodes("username")->get_node(1)->textContent;
		my $session = new CGI::Session();
		$session->param('admin', $named);
		$page->redirect("../public_html/admin_news.html");#modificare
	}else{
		$page->redirect("./admin.cgi?err=password%20errata");
	}
}else{
	$page->redirect("../public_html/admin.cgi?err=user%20errato");
}




#in caso negativo rispondere ad admin.html