package View;

use warnings;
use strict;

sub get_cost {
    my $cost = shift;

    print "Content-type: text/html\n\n";
    print 'Cost: '.$cost;
}

sub set_order {
    my $id = shift;

    print "Content-type: text/html\n\n";
    print 'Order ID: '.$id;
}

sub get_order {
    my $order = shift;

    print "Content-type: text/html\n\n";
    print 'ID: '.%$order{'id'}."<br>";
    print 'Price: '.%$order{'price'}."<br>";
    print 'Cost: '.%$order{'cost'}."<br>";
    print 'Name: '.%$order{'name'}."<br>";
}

sub error {
    my $error = shift;

    print "Content-type: text/html\n\n";
    print "Error!<br>";
    print $error;
    die;
}

1;