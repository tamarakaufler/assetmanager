use utf8;
package AssetManager::Schema::AssetManagerDB::Result::AssetCategory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AssetManager::Schema::AssetManagerDB::Result::AssetCategory

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<asset_category>

=cut

__PACKAGE__->table("asset_category");

=head1 ACCESSORS

=head2 asset

  data_type: 'integer'
  is_nullable: 0

=head2 category

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "asset",
  { data_type => "integer", is_nullable => 0 },
  "category",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</asset>

=item * L</category>

=back

=cut

__PACKAGE__->set_primary_key("asset", "category");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-01-17 00:37:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/NdN5TpxZrP3iEAexQ4nmw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;

__PACKAGE__->belongs_to(
  "asset",
  "AssetManager::Schema::AssetManagerDB::Result::Asset",
 # "AssetManager::Schema::Result::Asset",
  { id => "asset" },
  { is_deferrable => 1, on_update => "CASCADE" },
);
__PACKAGE__->belongs_to(
  "category",
  "AssetManager::Schema::AssetManagerDB::Result::Category",
  #"AssetManager::Schema::Result::Category",
  { id => "category" },
  { is_deferrable => 1, on_update => "CASCADE" },
);

1;
