-- Load the Event database. 

-- Drop the previous table declarations.
@&database\drop         
commit;
-- Reload the table declarations.
@&database\schema
commit;
-- Load the table data.
@&database\data
commit;