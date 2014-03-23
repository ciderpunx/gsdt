package gsdt::api::project;
use Dancer ':syntax';
use Dancer::Plugin::DBIC qw(schema resultset rset);
use Dancer::Plugin::Auth::Extensible;

set serializer => 'mutable';

prefix '/api/project';

get '/' => require_login sub {
    my @projects = map {
        id           => $_->id,
        status			 => $_->status,
        parent_id    => $_->parent_id,
        title        => $_->title,
        body         => $_->body,
        start        => $_->start,
        end          => $_->end,
    }, gsdt::_get_user( session 'logged_in_user_id' )->projects;
    if (@projects) { return \@projects }
		else { status 404 }
};

get '/:id' => require_login sub {
	my $project = _get_user_project_by_id(param 'id');
	my @action_ids = map {$_->id} $project->actions;
	if ($project) {
		return {
				id           => $project->id,
        status			 => $project->status,
        parent_id    => $project->parent_id,
        title        => $project->title,
        body         => $project->body,
        start        => $project->start,
        end          => $project->end,
				action_ids	 => \@action_ids,
		}
	}
	else { status 404 }
};

post '/create' => require_login sub {
	my $schema = schema 'gsdt';
	# TODO: Validate params
	my $project = $schema->resultset('Action')->create({
				user_id      => (session 'logged_in_user_id'),
        status       => param 'status',
        parent_id    => param 'parent_id',
        title        => param 'title',
        body         => param 'body',
        start        => param 'start',
        end          => param 'end',
	}); 

  if ($project) { status 204 }
	else					{ status 500 }
};

put '/:id' => require_login sub {
	my $schema = schema 'gsdt';
	# TODO: Validate params
	my $project = 	_get_user_project_by_id(param 'id');
	if($project) {
		my $r = $project->update({
					user_id      => (session 'logged_in_user_id'),
					status       => param 'status',
					parent_id    => param 'parent_id',
					title        => param 'title',
					body         => param 'body',
					start        => param 'start',
					end          => param 'end',
		}); 

		if ($r) { status 204 }
		else		{ status 500 }
	}
	else { status 404 }
};

del '/delete/:id' => require_login sub {
	my $schema = schema 'gsdt';
	my $project = 	_get_user_project_by_id(param 'id');
	if ($project) {
		my $r = $project->delete;
  
		if ($r) { status 204 }
		else		{ status 500 }
	}
	else { status 404 } 
};

any qr{.*} => require_login sub {
	status 405;
};

sub _get_user_project_by_id {
	my $id = shift;
	my $schema  = schema 'gsdt';
	my $p = $schema->resultset('Project')->search({
			id      => { '=', $id },
	})->first;
	return $p if ($p->users->first->id == session 'logged_in_user_id');
};

1;
