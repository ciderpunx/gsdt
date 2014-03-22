package gsdt::api::project;
use Dancer ':syntax';
use Dancer::Plugin::DBIC qw(schema resultset rset);
use Dancer::Plugin::Feed;
use Dancer::Plugin::Email;
use Dancer::Plugin::Auth::Extensible;

set serializer => 'mutable';

prefix '/api/project';

# List
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
    if (@projects) {
			return { projects => \@projects };
		}
		status 404;
};

# Show
get '/:id' => require_login sub {
	my $project = _get_user_project_by_id(param 'id');
	my @action_ids = map {$_->id} $project->actions;
	if ($project) {
		return {project => {
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
	}
	else {
		status 404;
	}
};

# Create
post '/create' => require_login sub {
	my $schema = schema 'gsdt';
	# TODO: Validate params
	my $project = $schema->resultset('Action')->create({
				user_id      => session 'logged_in_user_id',
        status       => param 'status',
        parent_id    => param 'parent_id',
        title        => param 'title',
        body         => param 'body',
        start        => param 'start',
        end          => param 'end',
	}); 

  if ($project) { status 204; }
	else					{ status 500; }
};

# Update
put '/:id' => require_login sub {
	my $schema = schema 'gsdt';
	# TODO: Validate params
	my $project = 	_get_user_project_by_id(param 'id');
	my $r = $project->update({
				user_id      => session 'logged_in_user_id',
        status       => param 'status',
        parent_id    => param 'parent_id',
        title        => param 'title',
        body         => param 'body',
        start        => param 'start',
        end          => param 'end',
	}); 

	if ($r) { status 204; }
	else		{ status 500; }
};

# Delete
del '/delete/:id' => require_login sub {
	my $schema = schema 'gsdt';
	my $project = 	_get_user_project_by_id(param 'id');
	my $r = $project->delete;
  
	if ($r) { status 204; }
	else		{ status 500; }
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
