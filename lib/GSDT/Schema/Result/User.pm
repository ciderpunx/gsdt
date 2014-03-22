use utf8;
package GSDT::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GSDT::Schema::Result::User

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

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 250

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=head2 created_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 0, size => 250 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 250 },
  "created_at",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 250 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2014-03-01 10:39:33
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:H/Wf4cBVzhW8Q3wDCJwysQ

__PACKAGE__->has_many("actions" => "GSDT::Schema::Result::Action" , "user_id" , { cascade_copy => 0, cascade_delete => 1 });

__PACKAGE__->has_many("user_context" => "GSDT::Schema::Result::UserContext", "user_id", { cascade_copy => 0, cascade_delete => 1 });
__PACKAGE__->many_to_many("contexts" => "user_context", "context");

__PACKAGE__->has_many("user_person" => "GSDT::Schema::Result::UserPerson", "user_id", { cascade_copy => 0, cascade_delete => 1 });
__PACKAGE__->many_to_many("people" => "user_project", "person");

__PACKAGE__->has_many("user_project" => "GSDT::Schema::Result::UserProject", "user_id", { cascade_copy => 0, cascade_delete => 1 });
__PACKAGE__->many_to_many("projects" => "user_project", "project");

__PACKAGE__->has_many("user_reference" => "GSDT::Schema::Result::UserReference", "user_id", { cascade_copy => 0, cascade_delete => 1 });
__PACKAGE__->many_to_many("references" => "user_reference", "reference");

1;
