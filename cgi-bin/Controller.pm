package Controller;

use warnings;
use strict;
use File::Basename;
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
    $response = $self->getCost() if $method eq 'getCost';
    $response = $self->setOrder() if $method eq 'setOrder';
    $response = $self->getOrder() if $method eq 'getOrder';

    View::viewError("Unknown method.") if $response == 0;

    return $response;
}

sub getCost {
    my $self = shift;
    my $request = $self->{request};
    my $price = $request->param('price');

    my $cost = Order::getCost($price);

    View::viewGetCost($cost);
}

sub setOrder {
    my $self = shift;
    my $request = $self->{request};
    my $price = $request->param('price');
    my $cost = $request->param('cost');
    my $name = $request->param('name');

    my $id = Order::setOrder($price, $cost, $name);

    View::viewSetOrder($id);
}

sub getOrder {
    my $self = shift;
    my $request = $self->{request};
    my $id = $request->param('id');

    my @order = Order::getOrder($id);

    View::viewGetOrder(@order);
}

1;