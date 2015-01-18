package AssetManager::Controller::Manager;
use Moose;
use namespace::autoclean;
use v5.018;

use AssetManager::Controller::Helper::Manager qw(
				                    get_listing
				                    create_entity
				                    update_entity
				                    delete_entity
                                              );

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AssetManager::Controller::Manager - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 list

=cut

sub list :Path('list') :Args(1) {
    my ( $self, $c, $type ) = @_;
    
    $c->stash->{ entities }  = get_listing($c, $type, $c->req->params);
    $c->stash->{ template }  = 'listing.tt';
#    $c->forward( $c->view('TT') );
}

=head2 create

=cut

sub create :Path('create') :Args(1) {
    my ( $self, $c, $type ) = @_;

    $c->stash->{ created }   = create_entity($c, $type);
    $c->stash->{ template }  = 'created.tt';
    
    $c->response->body('Matched AssetManager::Controller::Manager in Manager.');
}

=head2 update

=cut

sub update :Path('update') :Args(1) {
    my ( $self, $c, $type ) = @_;

    $c->stash->{ updated }   = update_entity($c, $type);
    $c->stash->{ template }  = 'updated.tt';

    $c->response->body('Matched AssetManager::Controller::Manager in Manager.');
}

=head2 delete

=cut

sub delete :Path('delete') :Args(1) {
    my ( $self, $c, $type ) = @_;

    $c->stash->{ deleted }   = delete_entity($c, $type);
    $c->stash->{ template }  = 'deleted.tt';

    $c->response->body('Matched AssetManager::Controller::Manager in Manager.');
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('index - Matched AssetManager::Controller::Manager in Manager.');
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
