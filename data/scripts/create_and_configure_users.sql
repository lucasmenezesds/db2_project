 -- Creating Users (3)
CREATE USER the_clerk IDENTIFIED BY 1234567890;
CREATE USER the_manager IDENTIFIED BY 1234567890;

-- Configuring the_clerk
GRANT CONNECT, RESOURCE, CREATE SESSION TO the_clerk;
GRANT clerk to the_clerk;

-- Configuring the_manager
GRANT CONNECT, RESOURCE, CREATE SESSION TO the_manager;
GRANT manager to the_manager;

COMMIT ;