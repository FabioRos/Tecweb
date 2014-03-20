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
	exit;
}

sub isdef{
	my $par = $_[0];
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
	my $aux = $cgi->div({-class => 'tag_title'}, 'Tag Articolo:');
	foreach my $tag ($ptrtags->get_nodelist){	
		$aux = $aux . $cgi->a(
			{
				-class =>'taglink',
				-tag => 'tag',
				-href => "searchtags.cgi?idtag=".$tag->findnodes("\@id")->get_node(1)->textContent
				},
				$tag->findnodes("node()")->get_node(1)->textContent
			);
		}
	return $aux;
}

sub feposts{
	my $ptrpos = $_[0]->findnodes("/posts/post");
	my $aux;
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
	$aux = $aux . $cgi->a({-href => "show.cgi?type=".$type."pag=".$pagina},$pagina);
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