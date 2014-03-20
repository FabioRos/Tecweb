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
my $xslt = XML::LibXSLT->new();

#sub getSession{
#	my $session = CGI::Session->load() or die $!;
#	if ($session->is_expired || $session->is_empty ) {
#		redir('admin.cgi?err=eseguire20il20login');
#	} else {
#		return $session->param('username');
#	}
#}


#my $utente=getSession;

my $fail = 0;
my $msg = "?";
my $type = $cgi->param('tipo');
my $titolo;
if($cgi->param('titolo') eq ""){
	$fail=1;
	$msg = $msg."msg1=stringavuota&&";
}else{$titolo=$cgi->param('titolo');}

#controllo della foto
my $srcfoto = $cgi->upload('src');
my $filename;

if($cgi->param('src') eq ""){
	$fail=1;
	$msg = $msg."msg1=nome%20del%20file%20vuoto&&";
}else{
	$filename=$cgi->param('src');
}


my $altfoto;
if($cgi->param('alt') eq ""){
	$fail=1;
	$msg = $msg."msg3=descrizione%20della%20foto%20vuota&&";
}else{$altfoto=$cgi->param('alt');}



my $descrizione;
if($cgi->param('excerpt') eq ""){
	$fail=1;
	$msg = $msg."msg4=descrizione%20del%20post%20vuoto&&";
}else{$descrizione=$cgi->param('excerpt');}


my $testo;
if($cgi->param('descrizione') eq ""){
	$fail=1;
	$msg=$msg."msg5=testo%20del%20post%20vuoto&&";
}else{$testo=$cgi->param('descrizione');}


my $tags;
if($cgi->param('tags') eq ""){
	$fail=1;
	$msg=$msg."msg6=nessun%20tag%20inserito&&";
}else{$tags=$cgi->param('tags');}


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
	if((!defined $cgi->param('dataEvento')) && $cgi->param('dataEvento') eq ""){
		$fail=1;
		$msg=$msg."msg7=data%20vuota&&";
	}else{$data=$cgi->param('dataEvento');}

	if((!defined $cgi->param('numGiorni')) && $cgi->param('numGiorni') eq ""){
		$fail=1;
		$msg=$msg."msg8=numero%20giorni%20vuoto&&";
	}else{$numgiorni=$cgi->param('numGiorni');}

	if((!defined $cgi->param('luogo')) && $cgi->param('luogo') eq ""){
		$fail=1;
		$msg=$msg."msg9=nessun%20luogo%20inserito&&";
	}else{$luogo=$cgi->param('luogo');}

	if((!defined $cgi->param('oraInizio')) && $cgi->param('oraInizio') eq ""){
		$fail=1;
		$msg=$msg."msg10=manca%20ora%20inizio&&";
	}else{$oraInizio=$cgi->param('oraInizio');}

	if((!defined $cgi->param('oraFine')) && $cgi->param('oraFine') eq ""){
		$fail=1;
		$msg=$msg."msg11=manca%20ora%20fine&&";
	}else{$oraFine=$cgi->param('oraFine');}

	if((!defined $cgi->param('indirizzo')) && $cgi->param('indirizzo') eq ""){
		$fail=1;
		$msg=$msg."msg12=manca%20ora%20fine&&";
	}else{$indirizzo=$cgi->param('indirizzo');}

	if((!defined $cgi->param('prezzo')) && $cgi->param('prezzo') eq ""){
		$fail=1;
		$msg=$msg."msg13=manca%20il%20prezzo&&";
	}else{$price=$cgi->param('prezzo');}

	if((!defined $cgi->param('mail')) && $cgi->param('mail') eq ""){
		$fail=1;
		$msg=$msg."msg14=manca%20la%20mail&&";
	}else{$mail=$cgi->param('mail');}

	if((!defined $cgi->param('telefono')) && $cgi->param('telefono') eq ""){
		$fail=1;
		$msg=$msg."msg15=manca%20il%20telefono&&";
	}else{$luogo=$cgi->param('telefono');}
}

my $intervistato;
my @gallery;
my @gallerynames;
if ($type eq 'i'){

	if((!defined $cgi->param('intervistato')) && $cgi->param('intervistato') eq ""){
		$fail=1;
		$msg=$msg."msg7=manca%20il%20nome%20intervistato&&";
	}else{$luogo=$cgi->param('intervistato');}

	my @gal = $cgi->upload("fgallery");
	my @galnms = $cgi->param("fgallery");
	my $galsize = scalar @gal;
	for(my $var = 0; $var< $galsize; $var++){
		if($gal[$var]){
			$gallery[$var]=$gal[$var];
			$gallerynames[$var]=$galnms[$var];
		}
	}	
}
if ($fail) {
	CFUN::redir(CFUN::getcaller($type.$msg));
}else{
	my $path = CFUN::getfolderpath($type);
	CFUN::scrivifile($srcfoto,$filename,$path);
	for (my $var = 0; $var < scalar @gallery; $var++) {
		CFUN::scrivifile($gallery[$var],$gallerynames[$var],"../public_html/img/interviste/gallery/");
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
	}
	);
print $cgi->h1("Funziona");


print $cgi->end_html;
