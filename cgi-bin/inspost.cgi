#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CFUN;


#sub getSession{
#	my $session = CGI::Session->load() or die $!;
#	if ($session->is_expired || $session->is_empty ) {
#		redir('admin.cgi?err=eseguire20il20login');
#	} else {
#		return $session->param('username');
#	}
#}

my $cgi = CGI->new();
my $xml = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();

#my $utente=getSession;


my $type = $cgi->param('tipo');
my $titolo = CFUN::isdef('titolo');
if($titolo eq ""){
	CFUN::redir("../admin_interviste.html?msg=stringavuota");
}
my $srcfoto = $cgi->upload('src');
my $filename = CFUN::isdef('src');
if($filename eq ""){
	CFUN::redir("../admin_interviste.html?msg=nome%20del%20file%20vuoto");
}
my $path = CFUN::getfolderpath($type);
CFUN::checkfile($srcfoto);
CFUN::scrivifile($srcfoto,$filename,$path);
my $altfoto = CFUN::isdef('alt');
if($altfoto eq ""){
	CFUN::redir("../admin_interviste.html?msg=descrizione%20della%20foto%20vuota");
}
my $descrizione = isdef('excerpt');
if($descrizione eq ""){
	CFUN::redir("../admin_interviste.html?msg=descrizione%20del%20post%20vuoto");
}
my $testo = isdef('descrizione');
if($testo eq ""){
	CFUN::redir("../admin_interviste.html?msg=testo%20del%20post%20vuoto");
}
my $tags = isdef('tags');
if($tags eq ""){
	CFUN::redir("../admin_interviste.html?msg=nessun%20tag%20inserito");
}


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
	$data = CFUN::isdef('dataEvento');
	$numgiorni = CFUN::isdef('numGiorni');
	$luogo = CFUN::isdef('luogo');
	$oraInizio = CFUN::isdef('oraInizio');
	$oraFine = CFUN::isdef('oraFine');
	$indirizzo = CFUN::isdef('indirizzo');
	$price = CFUN::isdef('prezzo');
	$mail = CFUN::isdef('email');
	$phone = CFUN::isdef('telefono');
}

my $intervistato;
my @gallery;
my @gallerynames;
if ($type eq 'i'){
	$intervistato = CFUN::isdef('intervistato');
	if($intervistato eq ""){
		CFUN::redir("../admin_interviste.html?msg=nome%20intervistatoe%20vuoto");
	}
	my @gal = $cgi->upload("fgallery");
	my @galnms = $cgi->param("fgallery");
	my $galsize = scalar @gal;
	for(my $var = 0; $var< $galsize; $var++){
		if(@gal[$var]){
			@gallery[$var]=@gal[$var];
			@gallerynames[$var]=@galnms[$var];
			CFUN::scrivifile(@gallery[$var],@gallerynames[$var],"../public_html/img/interviste/gallery/");
		}
	}	
}

print $cgi->header({-type=>'text/html', -charset=>'UTF-8'});
print $cgi->start_html(
	-title => "Admin - Music Break",
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
	{'media' => 'print','src' => '../css/print.css'},
	{'media' => 'speech','src' => '../css/aural.css'},
	{'media' => 'handheld, screen','src' => '../css/screen_login.css'}
	],
	-script =>[{'type' => 'text/javascript','src' => '../javascript/backend.js'}]
	);
print $cgi->div(
	{-id => 'header'},
	$cgi->a({-class => 'help' , -href => '#nav'}, 'salta intestazione'),
	$cgi->span(
		{-id => 'logo' , -class => 'notAural'}, 
		$cgi->img({-src => './img/tazza-di-caffe.jpg', -alt => 'Tazza di caffè fumante in cui viene immersa  una pausa di semiminima'})
		),
	$cgi->h1('<span xml:lang="eng">Music Break</span>'),
	$cgi->h2('Il portale di notizie dedicato alla musica')
	);
print $cgi->div(
	{-id => 'nav'},
	$cgi->a({-class => 'help', -href => '#contents'}, 'salta menù'),
	CFUN::afenav($type)
	);
#proseguire


print $cgi->end_html;