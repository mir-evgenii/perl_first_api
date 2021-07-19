package Order;

use warnings;
use strict;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use Model;
use Validation;
use View;

my $__COMMISSION = 1.05;

sub get_cost {
    my $price = shift;

    Validation::number($price);

    my $cost = $price * $__COMMISSION;
    return $cost;
}

sub set_order {
    my $price = shift;
    my $cost = shift;
    my $name = shift;

    Validation::number($price);
    Validation::number($cost);
    Validation::string($name);

    my $true_cost = get_cost($price);
    View::error("Not correct cost!") if $cost != $true_cost;

    my $DB = Model->new();
    my $id = $DB->set_order($price, $cost, $name);

    return $id;
}

sub get_order {
    my $id = shift;

    Validation::id($id);

    my $DB = Model->new();
    my %order = $DB->get_order($id);

    return %order;
}

1;