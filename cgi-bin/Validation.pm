package Validation;

use warnings;
use strict;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use View;

sub string {
    my $string = shift;

    View::error("Name is cannot be empty.") if $string eq '';
    View::error("Name cannot be more than 255 characters.") if length($string) > 255;
    View::error("Name should only contain letters, numbers and spaces.") if $string !~ /^[a-zA-Z0-9\s]+$/;
}

sub number {
    my $num = shift;

    View::error("Price or cost must be a number and more than 0.") if $num < 0;
    View::error("Price or cost should only contain numbers and simbol (.)") if $num !~ /^[0-9]+[.]{0,1}[0-9]*$/;
}

sub id {
    my $id = shift;

    View::error("Id should only contain numbers.") if $id !~ /^[0-9]+$/;
    View::error("Id must be a number and more than 0.") if $id <= 0;
}

1;