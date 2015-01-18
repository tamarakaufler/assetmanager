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

sub all {
    my $self = shift;

    say STDERR "*** Doing SQL SELECT ***";
    $logger->info("SELECT was performed: " . Dumper($self));

    my $entity = $self->next::method( @_ );

    return $entity; 
}

sub insert {
    my $self = shift;

    say STDERR "*** Inserting new entity ***";
    $logger->info("New entity created: " . Dumper($self));

    my $entity = $self->next::method( @_ );
    return $entity;
}

sub update {
    my $self = shift;

    say STDERR "*** Updating new entity ***";
    $logger->info("Entity updated: " . Dumper($self));

    my $entity  = $self->next::method( @_ );
    return $entity;
}

sub delete {
    my $self = shift;

    say STDERR "*** Deleting new entity ***";
    $logger->info("Entity deleted: " . Dumper($self));

    my $entity  = $self->next::method( @_ );
    return $entity;
}

1;
