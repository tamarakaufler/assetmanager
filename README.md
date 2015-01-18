# assetmanager
Catalyst web application

Purpose:

Playing, having fun, trying out things, sharing and more 

----------------
Work in progress
----------------

Web based admin tool for managing servers, 
located in datacentres (belongs-to relationship) and categorized (many-to-many relationship)

Provides:

a) GUI

b) RESTful API

Prerequisites:

    memcached running
    sql directory contains SQL for creating the database

Implementation:

    memcached for caching
    DBIx introspection used to create queries for any entity (table) 
    without unnecessary code duplication

Access:

start running the application by issuing: 
    
    script/assetmanager_server.pl -h localhost -p 3003 (any port that 
    works for you)

    http://localhost:3003/manager/list/asset
    http://localhost:3003/manager/list/asset?category=2
    http://localhost:3003/manager/list/asset?datacentre=2
    http://localhost:3003/manager/list/asset?category=2&datacentre=2
    http://localhost:3003/manager/list/category
    http://localhost:3003/manager/list/category

    http://localhost:3003/api/asset/datacentre/1
    http://localhost:3003/api/asset/name/server%202
    http://localhost:3003/api/category

    curl -X GET -H "Content-Type: application/json" http://localhost:3003/api/asset
    curl -X GET -H "Content-Type: application/json" http://localhost:3003/api/asset/datacentre/3
    curl -X GET -H "Content-Type: application/json" http://localhost:3003/api/asset/category/2
    curl -X GET -H "Content-Type: application/json" http://localhost:3003/api/asset/datacentre/1/category/2
