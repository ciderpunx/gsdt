use utf8;
package GSDT::Schema::Result::UserPerson;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GSDT::Schema::Result::UserPerson

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

=head1 TABLE: C<user_person>

=cut

__PACKAGE__->table("user_person");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=head2 person_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_nullable => 0 },
  "person_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<user_person>

=over 4

=item * L</user_id>

=item * L</person_id>

=back

=cut

__PACKAGE__->add_unique_constraint("user_person", ["user_id", "person_id"]);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2014-03-01 10:39:33
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UI1TKj+4x2FvAzgBf1X5tg

__PACKAGE__->belongs_to(person => 'GSDT::Schema::Result::Person', 'person_id');
__PACKAGE__->belongs_to(user    => 'GSDT::Schema::Result::User', 'user_id');

1;
