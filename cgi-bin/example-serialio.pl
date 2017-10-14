#!/usr/bin/perl -w

use strict;
use warnings;

use Device::SerialPort;

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

our $var;
$var = "CR0\r";


$pj -> write($var);
$var = $pj -> read(255);
print $var."\n";


