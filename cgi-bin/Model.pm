package Model;

use warnings;
use strict;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use View;
use DBI;
use Log;

my $__DB_NAME = '***';
my $__DB_USER = '***';
my $__DB_PASS = '***';

sub new {
    my $class = shift;
    my $DB = DBI->connect("DBI:mysql:$__DB_NAME","$__DB_USER","$__DB_PASS");

    $DB->{AutoCommit} = 0;
    $DB->{RaiseError} = 1;

    if(!$DB){
        __dbError();
    }else{
        my $self = bless({DB => $DB}, $class);
    }
}

sub set_order {
    my $self = shift;
    my $DB = $self->{DB};
    my $price = shift;
    my $cost = shift;
    my $name = shift;

    my $request = $DB->prepare("INSERT INTO orders (price, cost, name) VALUES (?, ?, ?)") or __db_error();
    $request->bind_param(1, $price);
    $request->bind_param(2, $cost);
    $request->bind_param(3, $name);
    $request->execute() or __db_error();

    $request = $DB->prepare("SELECT LAST_INSERT_ID()");
    $request->execute() or __db_error();

    $DB->commit() or __db_error();

    my $id = $request->fetchrow();

    return $id;
}

sub get_order {
    my $self = shift;
    my $DB = $self->{DB};
    my $id = shift;

    my $request = $DB->prepare("SELECT * FROM orders WHERE id=?") or __db_error();

    $request->bind_param(1, $id);
    
    $request->execute() or __db_error();

    my @order = $request->fetchrow_array();

    View::error('Order not found.') if (scalar @order == 0);

    my %order = (id     => $order[0], 
                 price  => $order[1],
                 cost   => $order[2],
                 name   => $order[3]);
    
    return %order;
}

sub __db_error {
    my $self = shift;
    my $DB = $self->{DB};
    my $error = $DB->errstr();

    Log::write($error) if $error ne '';

    View::error("Database error.");
}

1;
