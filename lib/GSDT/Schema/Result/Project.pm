use utf8;
package GSDT::Schema::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GSDT::Schema::Result::Project

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

=head1 TABLE: C<project>

=cut

__PACKAGE__->table("project");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 parent_id

  data_type: 'integer'
  is_nullable: 1

=head2 status

  data_type: 'enum'
  extra: {list => ["active","someday/maybe"]}
  is_nullable: 1

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 body

  data_type: 'text'
  is_nullable: 1

=head2 start

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 end

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "parent_id",
  { data_type => "integer", is_nullable => 1 },
  "status",
  {
    data_type => "enum",
    extra => { list => ["active", "someday/maybe"] },
    is_nullable => 1,
  },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "body",
  { data_type => "text", is_nullable => 1 },
  "start",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "end",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2014-02-22 19:28:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:b1NV7y3Z6o3cXbNHmIox4A

__PACKAGE__->has_many("user_project" => 'GSDT::Schema::Result::UserProject', 'project_id');
__PACKAGE__->many_to_many("users" => 'user_project', 'user');

__PACKAGE__->has_many("project_action" => 'GSDT::Schema::Result::ProjectAction', 'action_id');
__PACKAGE__->many_to_many("actions" => 'project_action', 'action');


1;
