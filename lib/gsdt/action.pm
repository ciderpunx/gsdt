package gsdt::action;
use Dancer ':syntax';
use Dancer::Plugin::DBIC qw(schema resultset rset);
use Dancer::Plugin::Auth::Extensible;

prefix '/action';

get '/' => sub {
	template "action-can", {
		title => "Get Stuff Done. Today. Actions",
		description => "A task management system: Actions",
		extra_script_imports => "js/action-can.js",
	};
}; 
