CREATE USER 'assetmanager'@'localhost' IDENTIFIED BY 'room101';
GRANT SELECT,INSERT,UPDATE,DELETE ON assetmanager.* TO assetmanager@'localhost' IDENTIFIED BY 'room101'; 
