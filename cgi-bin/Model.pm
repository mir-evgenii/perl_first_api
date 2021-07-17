package Model;

use warnings;
use strict;
use File::Basename;
use lib dirname(__FILE__);
use View;
use DBI;

my $__DB_NAME = '';
my $__DB_USER = '';
my $__DB_PASS = '';

sub new {
    my $class = shift;
    my $DB = DBI->connect("DBI:mysql:$__DB_NAME","$__DB_USER","$__DB_PASS");

    if(!$DB){
        __dbConnectError();
    }else{
        my $self = bless({DB => $DB}, $class);
    }
}

sub setOrder {
    my $self = shift;
    my $DB = $self->{DB};
    my $price = shift;
    my $cost = shift;
    my $name = shift;

    my $request = $DB->prepare("INSERT INTO orders (price, cost, name) VALUES ('$price','$cost','$name')") or __dbError();

    $request->execute() or __dbError();

    $request = $DB->prepare("SELECT MAX(id) FROM orders") or __dbError();
    
    $request->execute() or __dbError();

    my $id = $request->fetchrow();

    return $id;
}

sub getOrder {
    my $self = shift;
    my $DB = $self->{DB};
    my $id = shift;

    my $request = $DB->prepare("SELECT * FROM orders WHERE id='$id'") or __dbError();
    
    $request->execute() or __dbError();

    my @order = $request->fetchrow_array();

    View::viewError('Order not found.') if (scalar @order == 0);
    
    return @order;
}

sub __dbError {
    my $self = shift;
    my $DB = $self->{DB};

    View::viewError("Database error: $DB->errstr()");
}

sub __dbConnectError {
    my $self = shift;

    View::viewError("Database error: failed to connect.");
}

1;
