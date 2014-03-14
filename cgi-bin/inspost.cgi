#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;
use LWP::Protocol::file;
use CGI::Carp qw(fatalsToBrowser);

sub redir{ 
	my $rdr = $_[0];
	my $cgi = CGI->new();
	print $cgi->header({-type=>'text/html', -charset=>'UTF-8'});
	print $cgi->start_html(
	-title => "Logout - Music Break",
	-head => meta({-http_equiv => 'refresh',-content=> "0;url=$rdr"}),
	-dtd => ['-//W3C//DTD XHTML 1.0 Strict//EN','http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'],
	-lang => 'it'
	);
	print $cgi->end_html;
	exit;
}

sub isdef{
	my $par = $_[0];
	my $cgi = CGI->new();
	if(defined $cgi->param($par)){
		return my $param = $cgi->param($par);
	}else { redir("admin_news.html?msg=$par"); }
}

my $cgi = CGI->new();
my $xml = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();

my $utente = "PowerRanger";
#my $session = CGI::Session->load() or die $!;
#if ($session->is_expired || $session->is_empty ) {
#	redir('admin.cgi?err=eseguire20il20login');
#} else {
#	$utente = $session->param('username');
#}

#my $type = $cgi->param('tipo');
#my $titolo = isdef('titolo');
#my $srcfoto = isdef('src');
#my $altfoto = isdef('alt');
#my $descrizione = isdef('excerpt');
#my $testo = isdef('descrizione');
#my $tags = isdef('tags');


my $data;
my $numgiorni;
my $luogo;
my $oraInizio;
my $oraFine;
my $indirizzo;
my $price;
my $mail;
my $phone;
if($type eq 'e'){
	$data = isdef('dataEvento');
	$numgiorni = isdef('numGiorni');
	$luogo = isdef('luogo');
	$oraInizio = isdef('oraInizio');
	$oraFine = isdef('oraFine');
	$indirizzo = isdef('indirizzo');
	$price = isdef('prezzo');
	$mail = isdef('email');
	$phone = isdef('telefono');
}

my $intervistato;
my @gallery;#array di CGI::Upload
if ($type eq 'i'){
	$intervistato = isdef('intervistato');
	for (my $var = 1; $var < 11; $var++) {
		@gallery[$var-1] = $cgi->param("fgallery".$var);
	}
}