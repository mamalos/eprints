package EPrints::Plugin::Screen::EPMC::MultilangFields;

@ISA = ( 'EPrints::Plugin::Screen::EPMC' );

use strict;

sub new
{
	my( $class, %params ) = @_;

	my $self = $class->SUPER::new( %params );

	$self->{actions} = [qw( enable disable )];
	$self->{disable} = 1; # always enabled, even in lib/plugins

	$self->{package_name} = "MultilangFields";

	return $self;
}

sub action_enable
{
	my( $self, $skip_reload ) = @_;

	$self->SUPER::action_enable( $skip_reload );

	my $db = $self->{repository}->database;


	EPrints::XML::add_to_xml( $self->_workflow_file, $self->_xml, $self->{package_name} );	

	$self->reload_config if !$skip_reload;
}

sub action_disable
{
	my( $self, $skip_reload ) = @_;

	$self->SUPER::action_disable( $skip_reload );

	EPrints::XML::remove_package_from_xml( $self->_workflow_file, $self->{package_name} );

	$self->reload_config if !$skip_reload;
}

sub _workflow_file
{
	my ($self) = @_;

	return $self->{repository}->config( "config_path" )."/workflows/eprint/default.xml";
}

sub _xml
{
	my ($self) = @_;

	return <<END
<workflow xmlns="http://eprints.org/ep3/workflow" xmlns:epc="http://eprints.org/ep3/control">
	<stage name="core">
        <component><field ref="ml_title" required="yes" input_lookup_url="{$config{rel_cgipath}}/users/lookup/ml_title_duplicates" input_lookup_params="id={eprintid}&amp;dataset=eprint&amp;field=ml_title"/></component>
        <component><field ref="ml_abstract"/></component>
	</stage>
</workflow>
END
}

1;
