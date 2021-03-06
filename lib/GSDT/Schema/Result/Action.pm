use utf8;
package GSDT::Schema::Result::Action;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GSDT::Schema::Result::Action

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

=head1 TABLE: C<action>

=cut

__PACKAGE__->table("action");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 status

  data_type: 'enum'
  extra: {list => ["next","waiting","someday/maybe"]}
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 0
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

=head2 priority

  data_type: 'enum'
  extra: {list => ["high","medium","low"]}
  is_nullable: 1

=head2 hours_logged

  data_type: 'integer'
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "status",
  {
    data_type => "enum",
    extra => { list => ["next", "waiting", "someday/maybe"] },
    is_nullable => 0,
  },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 200 },
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
  "priority",
  {
    data_type => "enum",
    extra => { list => ["high", "medium", "low"] },
    is_nullable => 1,
  },
  "hours_logged",
  { data_type => "integer", is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2014-03-06 20:43:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wqElZZpa6HSOHdENIRzDog

__PACKAGE__->has_many("user_projects" => "GSDT::Schema::Result::UserProject", { 'foreign.project_id' => 'self.id' } );
__PACKAGE__->many_to_many("users" => "user_projects", "user_id");

__PACKAGE__->has_many("project_action" => "GSDT::Schema::Result::ProjectAction", { 'foreign.project_id' => 'self.id' } );
__PACKAGE__->many_to_many("projects" => "project_action", "project");

1;
