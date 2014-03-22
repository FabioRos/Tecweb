#!/usr/bin/perl -w
package CFUN;
use strict;
use warnings;
use XML::LibXSLT;
use XML::LibXML;
use CGI qw/:standard/;
use CGI::Session;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

my $cgi = CGI->new();
my $xml = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();
my $DBpath = "../data/XML/DBsite.xml";
my $source = XML::LibXML->load_xml(location => $DBpath);

sub getvincpath{
	my $type = $_[0];
	my $vincolo;
	if ($type eq 'e') {
		$vincolo = "eventi/evento";
	}elsif ($type eq 'r') {
		$vincolo = "recensioni/recensione";
	}elsif ($type eq 'i'){
		$vincolo = "interviste/intervista";
	}elsif ($type eq 'n'){
		$vincolo = "news/item";
	}
	return $vincolo;
}


sub getxslpath{
	my $type = $_[0];
	my $style_path;
	if ($type eq 'e') {
		$style_path="../data/XSLT/Eventi.xsl";
	}elsif ($type eq 'r') {
		$style_path="../data/XSLT/Recensioni.xsl";
	}elsif ($type eq 'i'){
		$style_path="../data/XSLT/Interviste.xsl";
	}elsif ($type eq 'n'){
		$style_path="../data/XSLT/News.xsl";
	}
	return $style_path;
}

sub redir{ 
	my $rdr = $_[0];
	print $cgi->header({-type=>'text/html', -charset=>'UTF-8'});
	print $cgi->start_html(
	-title => "Logout - Music Break",
	-head => meta({-http_equiv => 'refresh',-content=> "0;url=$rdr"}),
	-dtd => ['-//W3C//DTD XHTML 1.0 Strict//EN','http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'],
	-lang => 'it'
	);
	print $cgi->end_html;
	exit 0;
}

sub isdef{
	my $par = $_[0];
	if(defined $cgi->param($par)){
		return my $param = $cgi->param($par);
	}else{ 
		return 0; 
	}
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

sub fenav{
	my $type = $_[0];
	my $aux;
	if ($type eq 'n'){
		$aux = $aux . $cgi->ul(
						li($cgi->a({-href => 'home.xml'}, '<span xml:lang="en">Home</span>')),
						li({-id => 'current_nav'}, $cgi->p('<span xml:lang="en">News</span>')),
						li([
						$cgi->a({-href => 'show.cgi?type=i'}, 'Interviste'),
						$cgi->a({-href => 'show.cgi?type=r'}, 'Recensioni'),
						$cgi->a({-href => 'show.cgi?type=e'}, 'Eventi')
					])
			);
	} elsif ($type eq 'i'){
		$aux = $aux . $cgi->ul(
						li([$cgi->a({-href => 'home.xml'}, '<span xml:lang="en">Home</span>'),
						$cgi->a({-href => 'show.cgi?type=n'}, '<span xml:lang="en">News</span>')]),
						li({-id => 'current_nav'},$cgi->p('Interviste')),
						li([
						$cgi->a({-href => 'show.cgi?type=r'}, 'Recensioni'),
						$cgi->a({-href => 'show.cgi?type=e'}, 'Eventi')])
			);
	} elsif ($type eq 'r'){
		$aux = $aux . $cgi->ul(
						li([$cgi->a({-href => 'home.xml'}, '<span xml:lang="en">Home</span>'),
						$cgi->a({-href => 'show.cgi?type=n'}, '<span xml:lang="en">News</span>'),
						$cgi->a({-href => 'show.cgi?type=i'}, 'Interviste')]),
						li({-id => 'current_nav'}, $cgi->p('Recensioni')),
						li($cgi->a({-href => 'show.cgi?type=e'}, 'Eventi'))
			);
	} elsif ($type eq 'e'){
		$aux = $aux . $cgi->ul(
						li([$cgi->a({-href => 'home.xml'}, '<span xml:lang="en">Home</span>'),
						$cgi->a({-href => 'show.cgi?type=n'}, '<span xml:lang="en">News</span>'),
						$cgi->a({-href => 'show.cgi?type=i'}, 'Interviste'),
						$cgi->a({-href => 'show.cgi?type=r'}, 'Recensioni')]),
						li({-id => 'current_nav'}, $cgi->p('Eventi'))
			);
	}
	return $aux;
}


sub fetags{
	my $ptrtags = $_[0]->findnodes("tag");
	my $aux = '<ul class="tags">';
	foreach my $tag ($ptrtags->get_nodelist){	
		$aux = $aux . $cgi->li(
			$cgi->a({-href => "searchtags.cgi?idtag=".$tag->findnodes("\@id")->get_node(1)->textContent},
			$tag->findnodes("node()")->get_node(1)->textContent)
			);
	}
	$aux = $aux.'</ul>';
	return $aux;
}

sub feposts{
	my $ptrpos = $_[0]->findnodes("/posts/post");
	my $type= $_[1];
	my $aux = '';
	if($type eq 'e'){
		$aux = $aux.'<ul class="eventi">';
		foreach my $post ($ptrpos->get_nodelist){
			my ($year,$mon,$day)=split('-',$post->findnodes("dataEvento")->get_node(1)->textContent);
			$aux=$aux.$cgi->li(
				{-class=>'evento'},
				$cgi->div({-class=>'Intestazione'},
					$cgi->span({-class=>'giorno'},$day),
					$cgi->span({-class=>'mese'},$mon),
					$cgi->span({-class=>'anno'},$year),
					$cgi->span({-class=>'luogo'},$post->findnodes("luogo")->get_node(1)->textContent)
					),
				$cgi->div({-class=>'dettagli'},
						$cgi->div({-class=>'copertina'},
							$cgi->h2(
								$cgi->a(
									{-href => "posts.cgi?post=".$post->findnodes("\@id")->get_node(1)->textContent},
									$post->findnodes("titolo")->get_node(1)->textContent
									)
								),
							$cgi->img({
								-class => 'thumbnail', 
								-src => $post->findnodes("foto/src/node()")->get_node(1)->textContent,
								-alt => $post->findnodes("foto/alt/node()")->get_node(1)->textContent
								})
							),
						$cgi->p({-class => 'description'},$post->findnodes("excerpt")->get_node(1)->textContent),
						$cgi->p({-class => 'info'},
								$cgi->span({-class => 'luogo_specifico'},$post->findnodes("luogo")->get_node(1)->textContent),
								$cgi->span({-class => 'costo_biglietto'},$post->findnodes("prezzo")->get_node(1)->textContent),
								$cgi->span({-class => 'email'},$post->findnodes("email")->get_node(1)->textContent),
								$cgi->span({-class => 'telefono'},$post->findnodes("telefono")->get_node(1)->textContent)
							),
						fetags($post)
					)
				);
		}
		$aux = $aux.'</ul>';
	}else{
		foreach my $post ($ptrpos->get_nodelist){
			$aux = $aux . $cgi->div(
					{-class => 'article'},
					$cgi->h2( $cgi->a({-href => "posts.cgi?post=".$post->findnodes("\@id")->get_node(1)->textContent},$post->findnodes("titolo")->get_node(1)->textContent)),
					$cgi->span(
						{-class => 'author'}, 
						"di ".$post->findnodes("editore/nome")->get_node(1)->textContent." ".$post->findnodes("editore/cognome")->get_node(1)->textContent." ".$post->findnodes("data")->get_node(1)->textContent
						),
					$cgi->img(
						{-src => $post->findnodes("foto/src/node()")->get_node(1)->textContent, 
						-alt => $post->findnodes("foto/alt/node()")->get_node(1)->textContent}),
					$cgi->p($post->findnodes("excerpt")->get_node(1)->textContent),
					$cgi->a(
						{-class => 'continua' , -href => "posts.cgi?post=".$post->findnodes("\@id")->get_node(1)->textContent},
						"continua →"
						),
					fetags($post)
				);
		}
	}
	return $aux;
}

sub fenavpag{
	my $pagina = $_[0]+1;
	my $type = $_[1];
	my $inizio = $_[2];
	my $fine = $_[3];
	my $aux;
	if ($pagina > $inizio){
		$aux = $aux . $cgi->a({-href => "show.cgi?type=".$type."pag=".1},"<<");
		$aux = $aux . $cgi->a({-href => "show.cgi?type=".$type."pag=".$pagina-1},"<");
	}
	$aux = $aux . $cgi->span($pagina);
	if ($pagina < $fine){
		$aux = $aux . $cgi->a({-href => "show.cgi?type=".$type."pag=".$pagina+1},">");
		$aux = $aux . $cgi->a({-href => "show.cgi?type=".$type."pag=".$fine},">>");
	}
	return $aux;
}

sub getcaller{
	my $type=$_[0];
	my $aux;
	if ($type eq 'n'){
		$aux="../admin_news.html";
	} elsif ($type eq 'i'){
		$aux="../admin_interviste.html";
	} elsif ($type eq 'r'){
		$aux="../admin_recensioni.html";
	} elsif ($type eq 'e'){
		$aux="../admin_eventi.html";
	}
	return $aux;
}

sub getSession{
	my $session = CGI::Session->load() or die $!;
	if ($session->is_expired || $session->is_empty ) {
		redir('admin.cgi?err=eseguire20il20login');
	} else {
		return $session->param('id');
	}
}



sub getuniqueid{
	my $size = $_[0]->size();
	my $type = $_[1];
	return $type.$size;
}

sub createtag{
	my $tag = $_[0];
	my $src = $_[1];
	my $roottags = $src->findnodes("/root/tags")->get_node(1);
	my $tags = $roottags->findnodes("tag");
	my $id = $tags->size();
	my $tagnode = "<tag id='$id'>$tag</tag>";
	my $node = $xml->parse_balanced_chunk($tagnode,'UTF-8');
	$roottags->appendChild($node);
	return $id;
}

sub searchidtag{
	my $tag = $_[0];
	my $src = $_[1];
	my $DBtags = $src->findnodes("/root/tags/tag");
	foreach my $DBtag ($DBtags->get_nodelist){
		my $txttag = $DBtag->textContent;
		if($tag eq $txttag){
			my @attr = $DBtag->attributes();
			return $attr[0];
		}
	}
	return -1;
}

sub buildtagnodes{
	my $strtags = $_[0];
	my $src = $_[1];
	my $node = "";
	my @tags=split(',', $strtags);
	foreach my $tag (@tags){
		#$tag=trim($tag);
		my $idtag=searchidtag($tag,$src);
		if($idtag==-1){
			$idtag = createtag($tag,$src);
		}
		$node = $node."<tag>$idtag</tag>";
	}
	return $node;
}


sub creategallery{
	my $src = $_[0];
	my @gallerynms = @{$_[1]};
	my $rtgal = $src->findnodes("/root/gallerie")->get_node(1);
	my $id = $rtgal->findnodes("galleria")->size();
	my $node = "<galleria id='$id'>";
	my $size = scalar @gallerynms;
	foreach my $gnms (@gallerynms){
		$node =$node . "<foto><titolo>nome della foto $gnms</titolo><srcPath>/img/interviste/gallery/$gnms</srcPath></foto>";
	}
	$node = $node."</galleria>";
	my $aux = $xml->parse_balanced_chunk($node,'UTF-8');
	$rtgal->appendChild($aux);
	return $id;
}
