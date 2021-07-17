package View;

use warnings;
use strict;

sub viewGetCost {
    my $cost = shift;

    print "Content-type: text/html\n\n";
    print 'Cost: '.$cost;
}

sub viewSetOrder {
    my $id = shift;

    print "Content-type: text/html\n\n";
    print 'Order ID: '.$id;
}

sub viewGetOrder {
    my @order = @_;

    print "Content-type: text/html\n\n";
    print 'Order ID: '.$order[0]."<br>";
    print 'Price: '.$order[1]."<br>";
    print 'Cost: '.$order[2]."<br>";
    print 'Name: '.$order[3]."<br>";
}

sub viewError {
    my $error = shift;

    print "Content-type: text/html\n\n";
    print "Error!<br>";
    print $error;
    die;
}

1;