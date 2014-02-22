use utf8;
package GSDT::Schema::Result::ActionContext;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GSDT::Schema::Result::ActionContext

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

=head1 TABLE: C<action_context>

=cut

__PACKAGE__->table("action_context");

=head1 ACCESSORS

=head2 action_id

  data_type: 'integer'
  is_nullable: 0

=head2 context_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "action_id",
  { data_type => "integer", is_nullable => 0 },
  "context_id",
  { data_type => "integer", is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2014-02-22 19:28:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pm30cpopONxiJQB5J6oq6w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
