-- Enable RLS on all tables
ALTER TABLE tenants ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;

-- Create policies for admin role (can access all data)
CREATE POLICY admin_all_access ON tenants TO admin USING (true) WITH CHECK (true);
CREATE POLICY admin_all_access ON users TO admin USING (true) WITH CHECK (true);
CREATE POLICY admin_all_access ON categories TO admin USING (true) WITH CHECK (true);
CREATE POLICY admin_all_access ON products TO admin USING (true) WITH CHECK (true);
CREATE POLICY admin_all_access ON orders TO admin USING (true) WITH CHECK (true);
CREATE POLICY admin_all_access ON order_items TO admin USING (true) WITH CHECK (true);

-- Create policies for tenant_admin role (can access only their tenant's data)
CREATE POLICY tenant_admin_access ON tenants TO tenant_admin USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY tenant_admin_access ON users TO tenant_admin USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY tenant_admin_access ON categories TO tenant_admin USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY tenant_admin_access ON products TO tenant_admin USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY tenant_admin_access ON orders TO tenant_admin USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY tenant_admin_access ON order_items TO tenant_admin USING (tenant_id = current_setting('app.current_tenant_id')::int);

-- Create policies for manager role (read-only access to their tenant's data)
CREATE POLICY manager_read_access ON tenants TO manager USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY manager_read_access ON users TO manager USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY manager_read_access ON categories TO manager USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY manager_read_access ON products TO manager USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY manager_read_access ON orders TO manager USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY manager_read_access ON order_items TO manager USING (tenant_id = current_setting('app.current_tenant_id')::int);

-- Create policies for customer role (limited read access)
CREATE POLICY customer_read_categories ON categories TO customer USING (tenant_id = current_setting('app.current_tenant_id')::int);
CREATE POLICY customer_read_products ON products TO customer USING (tenant_id = current_setting('app.current_tenant_id')::int);