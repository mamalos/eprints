{
package EPrints::MetaField::Virtualwithvalue;

use strict;
use warnings;

use EPrints::MetaField;

our @ISA = qw( EPrints::MetaField );

use strict;

sub get_property_defaults
{
    my ( $self ) = @_;
    my %defaults = $self->SUPER::get_property_defaults;
#    $defaults{get_value} = undef;
#    $defaults{set_value} = undef;
    $defaults{get_value} = $EPrints::MetaField::UNDEF;
    $defaults{set_value} = $EPrints::MetaField::UNDEF;
    return %defaults;
}

sub get_value
{
    my( $self, $object ) = @_;
    if ( defined $self->get_property("get_value") )
    {
        return $self->call_property( "get_value", $object);
    }
    return undef;
}

sub set_value
{
     my( $self, $object, $value ) = @_;
     if ( defined $self->get_property("set_value") )
     {
         return $self->call_property( "set_value", $object, $value);
     }
     return undef;
}
}
