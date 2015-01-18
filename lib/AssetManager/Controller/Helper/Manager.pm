package AssetManager::Controller::Helper::Manager;

=head2 AssetManager::Controller::Helper::Manager

helper library for Controllers

=cut

use strict;
use warnings;
use v5.018;

use Lingua::EN::Inflect         qw(PL);
use Lingua::EN::Inflect::Number qw(to_S);
use JSON                        qw(from_json);

use Data::Dumper qw(Dumper);

$ENV{DBIC_TRACE} = 1;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(
                    get_listing
                    create_entity
                    update_entity
                    delete_entity

                    process_request4change_data

                    throws_error_api
                    error_exists_api
                 );

# --------------------------------- PUBLIC METHODS ---------------------------------

=head2 Public methods

used by Controllers

    get_listing
    create_entity
    update_entity
    delete_entity

    process_request4change_data

    throws_error_api
    error_exists_api

=cut

=head3 process_request4change_data

=cut

sub process_request4change_data {
        my ($c) = @_; 

        my ($type, $upload, $data);

        $type   = $c->stash->{entity_type};
        $upload = $c->request->upload('file');

        ## provided through -T/-d
        if ($c->req->data) {
            ## curl input already inflated/deserialized        
            $data = $c->req->data;
        }
        ## provided through -F
        elsif ($upload) {
                eval {
                    my $fh = $upload->fh;
                    {
                        local $/; 
                        my $encoded = <$fh>;
                        chomp $encoded;
                        $data = from_json($encoded);
                    }
                };
                if ($@) {
                        my $error;
                        $error->{ status }  = 'status_bad_request';
                        $error->{ message } = "Error: There were problems with processing your data: " . substr($@, 0, 160 );
    
                        return { error => $error };
                }
        }

        return $data;
}

sub get_listing {
    my ($c, $type, $params) = @_;

    my $search_option = _process_search_params($c, $type, $params);
    my @rows  = $c->model('AssetManagerDB::' . ucfirst(lc $type))
                  ->search( $search_option->{where},
                            $search_option->{join});

    my $entities = _massage4output($c, $type, \@rows);
}

sub create_entity {
    my ($c, $type, $data) = @_;

    my ($entity, $response);
    eval {
        $entity = $c->model('AssetManagerDB::' . ucfirst(lc $type))
                    ->create($data);
    };

    if ($@) {
        my $error = { error => { status  => 'status_bad_request', 
                                 message => "$type could not be created: " . substr($@, 0, 160 ),}
                    };
        return $error;
    }

    my $uri = $c->uri_for('/api/$type/id/' . $entity->id);

    # create a hashref response about the created object(s)a and return that
    $response = { %$data, link => "$uri" };

    return $response;

}

sub update_entity {
    my ($c, $type, $data) = @_;
}

sub delete_entity {
    my ($c, $type, $id) = @_;
}

=head3 throws_error_api

sets up a REST error response

IN:	Controller object
	Catalyst   object
	data structure that can be a hashref and contain error key
OUT:	undef on no errors
	array with status and message info

=cut

sub throws_error_api {
    my ($self, $c, $response ) = @_;

    my $error = error_exists_api($response);

    if ( $error ) {

        my ( $status, $message ) = ( $error->{ error }{ status }, $error->{ error }{ message } );
        $self->$status(
                            $c, 
                            message => $message,
                      );  
        $c->detach();
     }   

}

=head3 error_exists_api

IN:	hashref or arrayref
OUT:	undefined/error data structure 

=cut

sub error_exists_api {
    my ($data) = @_;

    my ($exists, $error);
    
    if ( ref $data eq 'HASH' &&
        exists $data->{ error } ) {
        $exists = $data;
    }
    elsif (ref  $data eq 'ARRAY' ) {
	my (@messages);
	foreach my $block ( @$data ) {
	    push @messages, $block->{ error }{ message } if ref $block eq 'HASH' && exists $block->{ error };
	}
	if (scalar @messages) {
	    $error = { error => { 
	    			status  => 'status_bad_request', 
	    			message => join "; ", @messages, 
	    		    } 
	    };
	    $exists = $error;
	}
    }

    return $exists;
}

# --------------------------------- PRIVATE METHODS ---------------------------------

=head3 Private methods

    _massage4output 
    _get_properties 
    _process_search_params 
    _transform_to_hashref 

=cut

sub _massage4output {
    my ($c, $type, $rows) = @_;

    my @massaged   = ();
    my $properties = _get_properties($c, $type);

    for my $row (@$rows) {
        my %massaged = ();

        for my $prop (@$properties) {
            my $name = $prop->{name};
            $massaged{$name} = ($prop->{is_rel}) ? $row->$name->name : $row->name;
        }
        push @massaged, \%massaged;
    }

    return \@massaged;
}

sub _get_properties {
    my ($c, $type) = @_;

    my $schema   = $c->model('AssetManagerDB')->source(ucfirst($type));
    my @columns = map { { name => $_, is_rel => $schema->has_relationship($_) } } $schema->columns;

    return \@columns;
}

sub _process_search_params {
    my ($c, $type, $search_option) = @_;

    $search_option = _transform_to_hashref($search_option) if ref ($search_option) eq 'ARRAY';

    #my $schema  = $c->model('AssetManagerDB')->schema;
    #my @sources = $schema->sources;

    my $schema  = $c->model('AssetManagerDB')->source(ucfirst $type);
    my @columns = $schema->columns;

    my $where = {};
    my $join  = [];

    for my $column (@columns) {
        if (exists $search_option->{$column}) {
            $where->{"me.$column"} = $search_option->{$column};
        }
    }
    for my $field (keys $search_option) {
        my $m2m_rel = "${type}_" . PL($field);

        if ($schema->has_relationship($m2m_rel)) {
            push @$join, $m2m_rel;
            $where->{"$m2m_rel.$field"} = $search_option->{$field};
        }
    }
    my $search = { where => $where, join => { join => $join } };

    return $search;
}

sub _transform_to_hashref {
    my ($search_option) = @_;

    return $search_option unless ref ($search_option) eq 'ARRAY';

    my $transformed = {};
    while (scalar @$search_option) {
        my ($key, $value) = (shift @$search_option, shift @$search_option);
        $transformed->{$key} = $value if defined $key && defined $value;
    }

    return $transformed;
}

1;
