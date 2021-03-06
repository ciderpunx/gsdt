use utf8;
package GSDT::Schema::Result::ProjectAction;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GSDT::Schema::Result::ProjectAction

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<project_action>

=cut

__PACKAGE__->table("project_action");

=head1 ACCESSORS

=head2 project_id

  data_type: 'integer'
  is_nullable: 0

=head2 action_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "project_id",
  { data_type => "integer", is_nullable => 0 },
  "action_id",
  { data_type => "integer", is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2014-02-22 19:28:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iAduQAaYsAYm/r4+2kJ2GQ

__PACKAGE__->belongs_to(project => 'GSDT::Schema::Result::Project', 'project_id');
__PACKAGE__->belongs_to(action  => 'GSDT::Schema::Result::Action', 'action_id');

1;
