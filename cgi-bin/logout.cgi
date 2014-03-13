#!/usr/bin/perl -w

use strict;
use warnings;
use CGI qw/:standard/;
use GCI::Session;

my $page = CGI->new();
my $session = GCI::Session->load() or die $!;
my $SID = $session->id();
$session->close();
$session->delete();
$session->flush();
$page->redirect("../public_html/admin.cgi?err=logout%20eseguito%20con%20successo");