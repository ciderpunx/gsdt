use utf8;
package GSDT::Schema::Result::Tickler;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GSDT::Schema::Result::Tickler

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

=head1 TABLE: C<tickler>

=cut

__PACKAGE__->table("tickler");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 next_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 recurs

  data_type: 'enum'
  extra: {list => ["once","daily","weekly","foortnightly","monthly","yearly"]}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "next_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "recurs",
  {
    data_type => "enum",
    extra => {
      list => ["once", "daily", "weekly", "foortnightly", "monthly", "yearly"],
    },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XFNVuyFb87S6ZdcO0lD/ow


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
