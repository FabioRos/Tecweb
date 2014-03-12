#!/usr/bin/perl -w

use strict;
use warnings;
use CGI qw/:standard/;
use GCI::Session;


my $session = GCI::Session->load() or die $!;
my $SID = $session->id();
$session->close();
$session->delete();
$session->flush();