use utf8;
package GSDT::Schema::Result::UserRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GSDT::Schema::Result::UserRole

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

=head1 TABLE: C<user_role>

=cut

__PACKAGE__->table("user_role");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=head2 role_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_nullable => 0 },
  "role_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<user_role>

=over 4

=item * L</user_id>

=item * L</role_id>

=back

=cut

__PACKAGE__->add_unique_constraint("user_role", ["user_id", "role_id"]);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2014-03-01 10:39:33
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HSeWvOwjqSdov5qtUvRXeg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
