package gsdt::action;
use Dancer ':syntax';
use Dancer::Plugin::DBIC qw(schema resultset rset);
use Dancer::Plugin::Feed;
use Dancer::Plugin::Email;
use Dancer::Plugin::Auth::Extensible;
#use Net::Akismet;
#use HTML::Entities;
#use HTML::Parser; ## needed for TagFilter, which calls SUPER on it.
#use HTML::TagFilter;
#use LWP::UserAgent;
#use URI::Escape;
#use Try::Tiny;


set serializer => 'mutable';

prefix '/action';


# List
get '/' => require_login sub {
    my @actions = map {
        id           => $_->id,
        status       => $_->status,
        title        => $_->title,
        body         => $_->body,
        start        => $_->start,
        end          => $_->end,
        priority     => $_->priority,
        hours_logged => $_->hours_logged,
    }, gsdt::_get_user( session 'logged_in_user_id' )->actions;
    return { actions => \@actions };
};

# Show
get '/:id' => require_login sub {

};

# Create
post => require_login sub {};

# Update
put '/:id' => require_login sub {

};

1;
