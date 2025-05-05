-- Create rol admin con acceso total a todo

CREATE ROLE admin LOGIN PASSWORD 'admin_password';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;

-- Create rol manager con lectura

CREATE ROLE manager LOGIN PASSWORD 'manager_password';
GRANT CONNECT ON DATABASE mydatabase TO manager;
GRANT USAGE ON SCHEMA public TO manager;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO manager;

-- Create rol costumer con lectura (Sin edicion y no ver todas las tablas)

CREATE ROLE customer LOGIN PASSWORD 'customer_password';
GRANT CONNECT ON DATABASE mydatabase TO customer;
GRANT USAGE ON SCHEMA public TO customer;
GRANT SELECT ON categories, products TO customer;

-- Create rol tenant_admin with full access but only to their tenant's data
CREATE ROLE tenant_admin LOGIN PASSWORD 'tenant_admin_password';
GRANT CONNECT ON DATABASE mydatabase TO tenant_admin;
GRANT USAGE ON SCHEMA public TO tenant_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO tenant_admin;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO tenant_admin;