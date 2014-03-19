#!/usr/bin/perl -w

use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

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
	}else { redir("../admin_interviste.html?msg=$par"); }
}

sub checkfile{
	my $file = $_[0];
	if (!$file) {
		redir("../admin_interviste.html?msg=upfallito");
	}
	return;
}

sub scrivifile{
	my $file = $_[0];
	my $filename = $_[1];
	my $path = $_[2];
	open (UPLOADFILE,">", $path.$filename);
	while (<$file>){
		print UPLOADFILE;
	}
	close UPLOADFILE;
}

sub getfolderpath{
	my $type=$_[0];
	if($type eq 'n'){
		return "../public_html/img/news/";}
	if($type eq 'r'){
		return "../public_html/img/recensioni/";}
	if($type eq 'i'){
		return "../public_html/img/interviste/";}
	if($type eq 'e'){
		return "../public_html/img/eventi/";}
}

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
my $titolo = isdef('titolo');
if($titolo eq ""){
	redir("../admin_interviste.html?msg=stringavuota");
}
my $srcfoto = $cgi->upload('src');
my $filename = isdef('src');
if($filename eq ""){
	redir("../admin_interviste.html?msg=nome%20del%20file%20vuoto");
}
my $path = getfolderpath($type);
checkfile($srcfoto);
scrivifile($srcfoto,$filename,$path);
my $altfoto = isdef('alt');
if($altfoto eq ""){
	redir("../admin_interviste.html?msg=descrizione%20della%20foto%20vuota");
}
my $descrizione = isdef('excerpt');
if($descrizione eq ""){
	redir("../admin_interviste.html?msg=descrizione%20del%20post%20vuoto");
}
my $testo = isdef('descrizione');
if($testo eq ""){
	redir("../admin_interviste.html?msg=testo%20del%20post%20vuoto");
}
my $tags = isdef('tags');
if($tags eq ""){
	redir("../admin_interviste.html?msg=nessun%20tag%20inserito");
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
my @gallery;
my @gallerynames;
if ($type eq 'i'){
	$intervistato = isdef('intervistato');
	if($intervistato eq ""){
		redir("../admin_interviste.html?msg=nome%20intervistatoe%20vuoto");
	}
	my @gal = $cgi->upload("fgallery[]");
	my @galnms = $cgi->param("fgallery[]");
	my $galsize = scalar @gal;
	for(my $var = 0; $var< $galsize; $var++){
		if(@gal[$var]){
			@gallery[$var]=@gal[$var];
			@gallerynames[$var]=@galnms[$var];
			scrivifile(@gallery[$var],@gallerynames[$var],"../public_html/img/interviste/gallery/");
		}
	}	
}
my $size = scalar @gallery;

print $cgi->header({-type=>'text/html', -charset=>'UTF-8'});
print $cgi->start_html(
	-title => "Login - Music Break",
	-dtd => ['-//W3C//DTD XHTML 1.0 Strict//EN','http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'],
	-lang => 'it',
	-meta => {
		'author' => 'Fabio Ros, Valerio Burlin, Stefano Munari, Alberto Andeliero',
		'language' => 'italian it',
		'rating' => 'safe for kids',
		'keywords' => 'inserimento post',
		'robots' => 'noindex,nofollow'
	}
	);
print $cgi->h1("Funziona!!!");

print $cgi->end_html;