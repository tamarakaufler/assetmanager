    --
    -- Create mysql database with the relevant tables
    --
    CREATE DATABASE IF NOT EXISTS assetmanager;
    USE assetmanager;

    DROP TABLE IF EXISTS asset;
    DROP TABLE IF EXISTS datacentre;
    DROP TABLE IF EXISTS category;
    DROP TABLE IF EXISTS asset_category;

    CREATE TABLE datacentre (
           id          	INT  NOT NULL PRIMARY KEY AUTO_INCREMENT,
           name        	VARCHAR(100) NOT NULL,
           UNIQUE KEY name_idx (name),
	   INDEX (name)
    ) ENGINE=InnoDB;
    CREATE TABLE asset (
           id          	INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
           name        	VARCHAR(100) NOT NULL,
	   datacentre	INT NOT NULL,	
	   FOREIGN KEY (datacentre) references datacentre(id),
           UNIQUE KEY name_datacentre_idx (name, datacentre),
	   INDEX (name, datacentre),
	   INDEX (datacentre)
    ) ENGINE=InnoDB;
    CREATE TABLE category (
           id          	INT  NOT NULL PRIMARY KEY AUTO_INCREMENT,
           name        	VARCHAR(100) NOT NULL,
           UNIQUE KEY name_idx (name),
	   INDEX (name)
    ) ENGINE=InnoDB;
    CREATE TABLE asset_category (
           asset     	INT NOT NULL,
           category     INT NOT NULL,
           UNIQUE KEY   asset_category_idx (asset, category),
	   PRIMARY KEY (asset, category)
    ) ENGINE=InnoDB;

	INSERT INTO datacentre VALUES (NULL, 'Europe');
	INSERT INTO datacentre VALUES (NULL, 'North America');
	INSERT INTO datacentre VALUES (NULL, 'South America');
	INSERT INTO datacentre VALUES (NULL, 'Asia');
	INSERT INTO datacentre VALUES (NULL, 'Africa');

	INSERT INTO category VALUES (NULL, 'loadbalancer');
	INSERT INTO category VALUES (NULL, 'scanning server');
	INSERT INTO category VALUES (NULL, 'database');

	INSERT INTO asset VALUES (NULL, 'server 1', 1); 
	INSERT INTO asset VALUES (NULL, 'server 2', 1);
	INSERT INTO asset VALUES (NULL, 'server 3', 1);

	INSERT INTO asset VALUES (NULL, 'server 2', 2);
	INSERT INTO asset VALUES (NULL, 'server 3', 2);
	INSERT INTO asset VALUES (NULL, 'server 4', 2);

	INSERT INTO asset VALUES (NULL, 'server 3', 3);
	INSERT INTO asset VALUES (NULL, 'server 4', 3);

	INSERT INTO asset VALUES (NULL, 'server 1', 4);
	INSERT INTO asset VALUES (NULL, 'server 2', 4);
	INSERT INTO asset VALUES (NULL, 'server 3', 4);
	INSERT INTO asset VALUES (NULL, 'server 4', 4);
	INSERT INTO asset VALUES (NULL, 'server 5', 4);

	INSERT INTO asset VALUES (NULL, 'server 1', 5);
	INSERT INTO asset VALUES (NULL, 'server 2', 5);

	INSERT INTO asset_category VALUES (1, 1);
	INSERT INTO asset_category VALUES (2, 1);
	INSERT INTO asset_category VALUES (3, 2);
	INSERT INTO asset_category VALUES (3, 3);
	INSERT INTO asset_category VALUES (4, 2);
	INSERT INTO asset_category VALUES (4, 3);
	INSERT INTO asset_category VALUES (5, 2);
	INSERT INTO asset_category VALUES (5, 3);
	INSERT INTO asset_category VALUES (6, 1);
	INSERT INTO asset_category VALUES (6, 2);
	INSERT INTO asset_category VALUES (7, 1);
	INSERT INTO asset_category VALUES (7, 2);
	INSERT INTO asset_category VALUES (7, 3);

	INSERT INTO asset_category VALUES (8, 1);
	INSERT INTO asset_category VALUES (8, 2);
	INSERT INTO asset_category VALUES (8, 3);
	INSERT INTO asset_category VALUES (9, 1);
	INSERT INTO asset_category VALUES (9, 2);
	INSERT INTO asset_category VALUES (9, 3);
	INSERT INTO asset_category VALUES (10, 2);
	INSERT INTO asset_category VALUES (10, 3);
	INSERT INTO asset_category VALUES (11, 1);
	INSERT INTO asset_category VALUES (11, 2);
	INSERT INTO asset_category VALUES (12, 2);
	INSERT INTO asset_category VALUES (12, 3);
	INSERT INTO asset_category VALUES (13, 1);
	INSERT INTO asset_category VALUES (13, 3);
	INSERT INTO asset_category VALUES (14, 1);
	INSERT INTO asset_category VALUES (15, 2);
