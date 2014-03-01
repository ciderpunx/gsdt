package gsdt;
use Dancer ':syntax'; 
use Dancer::Plugin::Cache::CHI;
use Dancer::Plugin::Auth::Extensible;

our $VERSION = '0.1';

check_page_cache;

get '/dashboard' => require_login sub {
	template "index", {
		info => "You are on the dashboard",	
		title => "Get Stuff Done. Today.",
		description => "A task management system.",
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
        session logged_in_user       => params->{username};
        session logged_in_user_realm => $realm;
				redirect uri_for '/dashboard';
    }
    else {
			template "index", {
				errors => ["You can't log in. Check your spelling?"], 
			};
    }
};

any '/logout' => sub {
	session->destroy;
	template "index", {
		info => "Logged out.", 
	}
};

true;
