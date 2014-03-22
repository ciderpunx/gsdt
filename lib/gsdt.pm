package gsdt;
use Data::Dumper;
use Dancer ':syntax'; 
use Dancer::Plugin::Cache::CHI;
use Dancer::Plugin::DBIC qw(schema resultset rset);
use Dancer::Plugin::Auth::Extensible;
use Dancer::Plugin::FlashMessage;

use gsdt::action;

our $VERSION = '0.1';

prefix undef;

# check_page_cache;

get '/dashboard' => require_login sub {
	my @user_actions = _get_user(session 'logged_in_user_id')->actions;
	template "dashboard", {
		title				=> "Dashboard: Get Stuff Done. Today.",
		description => "Get Stuff Done. Today. Dashboard.",
		actions			=> \@user_actions,
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
        session logged_in_user       => $user->username;
				session logged_in_user_id    => $user->id;
        session logged_in_user_realm => $realm;
				flash info				=> "You logged in. Well, hello.";	
				redirect params->{return_url} || uri_for '/dashboard';
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
	})->first;
}

sub _get_user {
	my $userid = shift; 
	my $schema  = schema 'gsdt';
	my $user = $schema->resultset('User')->search({
			id => { '=', $userid } ,
	})->first;
	return unless $user; # TODO: blow up rather than returning nothing


}

true;
