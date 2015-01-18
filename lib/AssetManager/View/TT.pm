package AssetManager::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    INCLUDE_PATH => [
        AssetManager->path_to( 'root', 'templates' ),
        AssetManager->path_to( 'root', 'lib' )
    ],
    PRE_PROCESS  => 'config/main',
    WRAPPER      => 'site/wrapper',
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

AssetManager::View::TT - TT View for AssetManager

=head1 DESCRIPTION

TT View for AssetManager.

=head1 SEE ALSO

L<AssetManager>

=head1 AUTHOR

Tamara Kaufler,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
