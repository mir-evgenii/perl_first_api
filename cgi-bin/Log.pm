package Log;

use warnings;
use strict;
use File::Basename qw(dirname);
use lib dirname(__FILE__);

my $__LOG_FILE = 'log.txt';

sub write {
    my $log_string = shift;
    my $datestring = localtime();

    open(my $log_file, '>>', "$__LOG_FILE");
    print $log_file "$datestring $log_string\n";
    close $log_file;
}

1;