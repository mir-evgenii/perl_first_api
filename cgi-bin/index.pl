#!/usr/bin/perl

use warnings;
use strict;
use File::Basename;
use lib dirname(__FILE__);
use CGI;
use Controller;

my $cgi = new CGI;
my $ctrl = Controller->new({request => $cgi});

$ctrl->run();
