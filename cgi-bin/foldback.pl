#!/usr/bin/perl -w

## This script generally doesn't exist.
## But when it does, it should live at:
## /var/www/cgi-bin/foldback.pl

## For some reason, the Foldback projectors
## in the Worship Center, like to spit out
## unnecessary "gibberish" bytes at the
## beginning of each and every response.

## This script is a modified version
## of the "raw.pl" script, with the
## sole purpose of stripping out those
## pesky extra bytes.


use warnings;
use strict;
use CGI;
use Device::SerialPort;

#use PackingBytes;


# calling it PJ because ProJector
our $pj = Device::SerialPort -> new ("/dev/ttyS0");

sub setupPJ {
        $pj -> baudrate(19200);
        $pj -> parity('none');
        $pj -> databits(8);
        $pj -> stopbits(1);
#       $pj -> handshake('none');
#       $pj -> write_settings;
        $pj -> read_char_time(0);
        $pj -> read_const_time(250);
}
setupPJ;


#my $cgi = CGI -> new;
my $cgi = new CGI;
my $value = $cgi -> param('cmd');



## FOR EXTRON COMPATIBILITY
## STRIP THE 'W01RS|' IF IT
## EXISTS IN THE STRING

$value =~ s/^W01RS\|//i;

#####



# use one of these two:
#$value = packing($value);
$value =~ s/%../pack('C', hex($1))/g;


$pj -> write($value);
my $retValue = $pj -> read(255);
my @ASCII = unpack("C*", $retValue);
my $nullz;
# "shift" removes $array[0], then
# moves all elements over so $array[1]
# becomes $array[0], etc...
$nullz = shift(@ASCII);
$nullz = shift(@ASCII);
$nullz = shift(@ASCII);
$nullz = shift(@ASCII);
$nullz = shift(@ASCII);
$nullz = shift(@ASCII);
$nullz = shift(@ASCII);
$nullz = shift(@ASCII);

print (
	$cgi -> header,
	#$cgi -> h1("\n".$retValue."\n")
);
$retValue = pack("C*", @ASCII);
print $retValue;
