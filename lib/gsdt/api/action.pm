package gsdt::api::action;
use Dancer ':syntax';
use Dancer::Plugin::DBIC qw(schema resultset rset);
use Dancer::Plugin::Auth::Extensible;

set serializer => 'mutable';

prefix '/api/action';

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

		if(@actions) { return \@actions }
		else				 { return 404 }
};

get '/:id' => require_login sub {
	my $action = _get_user_action_by_id(param 'id');
	if ($action) {
		return {action => {
		    user_id			 => (session 'logged_in_user_id'),
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
	else { status 404 }
};

post '/create' => require_login sub {
	my $schema = schema 'gsdt';
	# TODO: Validate params
	my $action = $schema->resultset('Action')->create({
				user_id      => (session 'logged_in_user_id'),
        status       => param 'status',
        title        => param 'title',
        body         => param 'body',
        start        => param 'start',
        end          => param 'end',
        priority     => param 'priority',
        hours_logged => param 'hours_logged',
	}); 

  if ($action) { status 204 }
	else				 { status 500 }
};

put '/:id' => require_login sub {
	my $schema = schema 'gsdt';
	# TODO: Validate params
	my $action = 	_get_user_action_by_id(param 'id');

	if($action) {
		my $r = $action->update({
					user_id      => (session 'logged_in_user_id'),
					status       => param 'status',
					title        => param 'title',
					body         => param 'body',
					start        => param 'start',
					end          => param 'end',
					priority     => param 'priority',
					hours_logged => param 'hours_logged',
		}); 

		if ($r) { status 204 }
		else		{ status 500 }
	}
	else { status 404 }
};

del '/delete/:id' => require_login sub {
	my $schema = schema 'gsdt';
	my $action = 	_get_user_action_by_id(param 'id');
	if($action) {
		my $r = $action->delete;

		if ($r) { status 204 }
		else		{ status 500 }
	}
	else { status 404 }

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
