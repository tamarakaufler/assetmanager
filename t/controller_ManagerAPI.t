use strict;
use warnings;
use Test::More;


use Catalyst::Test 'AssetManager';
use AssetManager::Controller::ManagerAPI;

ok( request('/managerapi')->is_success, 'Request should succeed' );
done_testing();
