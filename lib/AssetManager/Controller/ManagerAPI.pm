package AssetManager::Controller::ManagerAPI;
use Moose;
use namespace::autoclean;
use v5.018;

use AssetManager::Controller::Helper::Manager qw(
				                    get_listing
				                    create_entity
				                    update_entity
				                    delete_entity
                                              );

BEGIN { extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(default => 'application/json');

=head1 NAME

AssetManager::Controller::ManagerAPI - Catalyst RESTful Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched AssetManager::Controller::ManagerAPI in ManagerAPI.');
}

sub api  :Path('/api')   :ActionClass('REST') {
    my ( $self, $c, @url_params ) = @_;

    # TODO: throw error if the first url parameter is not a valid entity (one of the database tables)
    $c->stash->{ entity_type }   = shift @url_params;
    $c->stash->{ search_params } = \@url_params;
}

=head2 api_GET

=cut

sub api_GET {
    my ( $self, $c ) = @_;

    say STDERR "in api_GET: before process_GET_request";

    my $response_data = get_listing($c, $c->stash->{entity_type}, $c->stash->{ search_params });
    #throws_error_api($self, $c, $response_data);

    $self->status_ok(
                        $c,
                        entity => $response_data,
                    );

}

=head2 api_PUT

=cut

sub api_PUT {
    my ( $self, $c ) = @_;

}

=head2 api_POST

=cut

sub api_POST {
    my ( $self, $c ) = @_;

}

=head2 api_DELETE

=cut

sub api_DELETE {
    my ( $self, $c ) = @_;

}

=encoding utf8

=head1 AUTHOR

Tamara Kaufler,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
