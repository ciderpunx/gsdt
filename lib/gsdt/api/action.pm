package gsdt::api::action;
use Dancer ':syntax';
use Dancer::Plugin::DBIC qw(schema resultset rset);
use Dancer::Plugin::Feed;
use Dancer::Plugin::Email;
use Dancer::Plugin::Auth::Extensible;

set serializer => 'mutable';

prefix '/api/action';

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
	my $action = _get_user_action_by_id(param 'id');
	if ($action) {
		return {action => {
		    id           => $action->id,
        status       => $action->status,
        title        => $action->title,
        body         => $action->body,
        start        => $action->start,
        end          => $action->end,
        priority     => $action->priority,
        hours_logged => $action->hours_logged,
			}
		}
	}
	else {
		status 204;
	}
};

# Create
post '/create' => require_login sub {
	my $schema = schema 'gsdt';
	# TODO: Validate params
	my $action = $schema->resultset('Action')->create({
				user_id      => session 'logged_in_user_id',
        status       => param 'status',
        title        => param 'title',
        body         => param 'body',
        start        => param 'start',
        end          => param 'end',
        priority     => param 'priority',
        hours_logged => param 'hours_logged',
	}); 
  status 204;
};

# Update
put '/:id' => require_login sub {
	my $schema = schema 'gsdt';
	# TODO: Validate params
	my $action = 	_get_user_action_by_id(param 'id');
	$action->update({
				user_id      => session 'logged_in_user_id',
        status       => param 'status',
        title        => param 'title',
        body         => param 'body',
        start        => param 'start',
        end          => param 'end',
        priority     => param 'priority',
        hours_logged => param 'hours_logged',
	}); 
  status 204;
};

# Delete
del '/delete/:id' => require_login sub {
	my $schema = schema 'gsdt';
	my $action = 	_get_user_action_by_id(param 'id');
	$action->delete;
  status 204;
};

sub _get_user_action_by_id {
	my $id = shift;
	my $schema  = schema 'gsdt';
	return $schema->resultset('Action')->search({
			id      => { '=', $id },
			user_id => { '=', (session 'logged_in_user_id') } ,
	})->first;
};

1;
