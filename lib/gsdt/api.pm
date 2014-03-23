package gsdt::api;
use Dancer ':syntax';
use Dancer::Plugin::Auth::Extensible;

use gsdt::api::action;
use gsdt::api::project;

set serializer => 'mutable';

prefix '/api/';

any qr{.*} => require_login sub {
	status 405;
};
