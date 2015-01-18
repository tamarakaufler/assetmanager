use strict;
use warnings;
use Test::More;


use Catalyst::Test 'AssetManager';
use AssetManager::Controller::Manager;

ok( request('/manager')->is_success, 'Request should succeed' );
done_testing();
