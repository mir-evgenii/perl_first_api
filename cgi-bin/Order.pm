package Order;

use warnings;
use strict;
use File::Basename;
use lib dirname(__FILE__);
use Model;
use View;

my $__COMMISSION = 1.05;

sub getCost {
    my $price = shift;

    View::viewError("Price must be a number and more than 1.") if $price < 1;

    my $cost = $price * $__COMMISSION;
    return $cost;
}

sub setOrder {
    my $price = shift;
    my $cost = shift;
    my $name = shift;

    my $trueCost = getCost($price);

    View::viewError("Price must be a number and more than 1.") if $price < 1;
    View::viewError("Not correct cost!") if $cost != $trueCost;

    my $DB = Model->new();
    my $id = $DB->setOrder($price, $cost, $name);

    return $id;
}

sub getOrder {
    my $id = shift;

    View::viewError("Id must be a number and more than 0.") if $id < 1;

    my $DB = Model->new();
    my @order = $DB->getOrder($id);

    return @order;
}

1;