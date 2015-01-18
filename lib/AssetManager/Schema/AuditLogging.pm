use utf8;
package AssetManager::Schema::AuditLogging;

=head1 AssetManager::Schema::AuditLogging

DBIx::Class Component for over-riding Insert/Delete/Update

=cut

use parent qw(DBIx::Class);

use strict;
use warnings;
use v5.018;

use FindBin         qw($Bin);
use Data::Dumper    qw(Dumper);

use Log::Log4perl;
Log::Log4perl->init("$Bin/../log4perl.init");

my $logger = Log::Log4perl->get_logger("AssetManager::Schema::AuditLogging");

#use AssetManager::Schema::Helper::AuditLoggingHelper qw(updateAuditLog serializeDiff objToHash);

sub all {
    my $self = shift;

    say STDERR "*** Doing SQL SELECT ***";
    $logger->info("SELECT was performed: " . Dumper($self));

    my $entity = $self->next::method( @_ );

    return $entity; 
}

sub insert {
    my $self = shift;

    my $entity = $self->next::method( @_ );

#    updateAuditLog( $entity, 'I', 0 );

    return $entity;
}

sub delete {
    my $self = shift;

#    my $oriHash = objToHash( $self );

    my $entity  = $self->next::method( @_ );

 #   my ( $action, $data ) = serializeDiff( $oriHash, {} );

 #   updateAuditLog( $entity, 'P', 0, $data );

    return $entity;
}

sub update {
    my $self = shift;

#    my $oriHash = objToHash( $self );

    my $entity  = $self->next::method( @_ );

 #   my ( $action, $data )  = serializeDiff( $oriHash, objToHash( $entity ) );

 #   updateAuditLog( $entity, $action, 0, $data );

    return $entity;
}

1;
