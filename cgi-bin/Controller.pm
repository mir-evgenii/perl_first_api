package Controller;

use warnings;
use strict;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use Order;
use View;

sub new {
    my ($class,$args) = @_;

    my $self = bless({request => $args->{request}}, $class);
}

sub run {
    my $self = shift;
    my $request = $self->{request};
    my $method = $request->param('method');
    my $response;

    $response = 0;
    $response = $self->get_cost() if $method eq 'getCost';
    $response = $self->set_order() if $method eq 'setOrder';
    $response = $self->get_order() if $method eq 'getOrder';

    View::error("Unknown method.") if $response == 0;

    return $response;
}

sub get_cost {
    my $self = shift;
    my $request = $self->{request};
    my $price = $request->param('price');

    my $cost = Order::get_cost($price);

    View::get_cost($cost);
}

sub set_order {
    my $self = shift;
    my $request = $self->{request};
    my $price = $request->param('price');
    my $cost = $request->param('cost');
    my $name = $request->param('name');

    my $id = Order::set_order($price, $cost, $name);

    View::set_order($id);
}

sub get_order {
    my $self = shift;
    my $request = $self->{request};
    my $id = $request->param('id');

    my %order = Order::get_order($id);

    View::get_order(\%order);
}

1;