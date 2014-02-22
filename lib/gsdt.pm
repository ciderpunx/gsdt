package gsdt;
use Dancer ':syntax'; 
use Dancer::Plugin::Cache::CHI;

our $VERSION = '0.1';

check_page_cache;

get '/' => sub {
	template "index";
};



true;
