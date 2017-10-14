#!/usr/bin/perl -w

use warnings;
use strict;
use CGI;
use PackingBytes;

#my $cgi = CGI -> new;
my $cgi = new CGI;
my $value = $cgi -> param('cmd');

# use one of these two:
#$value = packing($value);
#$value =~ s/%../pack('C', hex($1))/g;





print (
	$cgi -> header,
	$cgi -> h1($value),
	$cgi -> start_html,
	$cgi -> end_html
);


