package gsdt;
use Dancer ':syntax'; 
use Dancer::Plugin::Cache::CHI;
use Dancer::Plugin::DBIC qw(schema resultset rset);
use Dancer::Plugin::Auth::Extensible;
use Dancer::Plugin::FlashMessage;

our $VERSION = '0.1';

check_page_cache;

get '/dashboard' => require_login sub {
	my $user_actions = _get_user(logged_in_user('userid'))->first()->user_actions();
	template "dashboard", {
		title				=> "Dashboard: Get Stuff Done. Today.",
		description => "Get Stuff Done. Today. Dashboard.",
		actions			=> $user_actions,
	};
};

get '/' => sub {
	template "index", {
		title => "Get Stuff Done. Today.",
		description => "A task management system.",
	};
};

get '/login' => sub {
	redirect uri_for '/';
};

post '/login' => sub {
    my ( $success, $realm ) =
      authenticate_user( params->{username}, params->{password} );
    if ($success) {
				my $user = _get_user_by_name(params->{username});
				if(!$user) {
					template "index", {
						flash errors => ["You can't log in. Check your spelling?"], 
					};
					return;
				}
        session logged_in_user       => {username => $user->{username}, userid => $user->{id}};
        session logged_in_user_realm => $realm;
				flash info				=> "You logged in. Well, hello.";	
				forward uri_for '/dashboard';
    }
    else {
			template "index", {
				flash errors => ["You can't log in. Check your spelling?"], 
			};
    }
};

any '/logout' => sub {
	session->destroy;
	template "index", {
		flash info => "Logged out.", 
	}
};


sub _get_user_by_name {
	my $username = shift; 
	my $schema  = schema 'gsdt';
	my $user = $schema->resultset('User')->search({
			username => { '=', $username } ,
	});
}

sub _get_user {
	my $userid = shift; 
	my $schema  = schema 'gsdt';
	my $user = $schema->resultset('User')->search({
			id => { '=', $userid } ,
	});
	return unless $user; # TODO: blow up rather than returning nothing


}

true;
