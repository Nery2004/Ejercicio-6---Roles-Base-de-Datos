-- Ejecutar este script completo para verificar todo el sistema

-- 1. Admin tests
\c mydatabase admin
SET app.current_tenant_id = '1';
SELECT 'ADMIN TEST: SELECT all tenants' AS test, COUNT(*) FROM tenants;
INSERT INTO tenants (name, dominio) VALUES ('Nuevo Tenant', 'nuevo.com');
SELECT 'ADMIN TEST: INSERT new tenant' AS test, * FROM tenants WHERE dominio = 'nuevo.com';

-- 2. Tenant_admin tests
\c mydatabase tenant_admin
SET app.current_tenant_id = '1';
SELECT 'TENANT_ADMIN TEST: SELECT products' AS test, COUNT(*) FROM products;
BEGIN;
  INSERT INTO products (tenant_id, name, price) VALUES (1, 'Webcam HD', 69.99);
  SELECT 'TENANT_ADMIN TEST: INSERT product' AS test, * FROM products WHERE name = 'Webcam HD';
ROLLBACK;

-- 3. Manager tests
\c mydatabase manager
SET app.current_tenant_id = '1';
SELECT 'MANAGER TEST: SELECT orders' AS test, COUNT(*) FROM orders;
SELECT 'MANAGER TEST: FAIL INSERT' AS test, 
  (SELECT COUNT(*) FROM products) AS before_count,
  (INSERT INTO products (tenant_id, name, price) VALUES (1, 'Test', 1)) AS attempt,
  (SELECT COUNT(*) FROM products) AS after_count;

-- 4. Customer tests
\c mydatabase customer
SET app.current_tenant_id = '1';
SELECT 'CUSTOMER TEST: SELECT products' AS test, COUNT(*) FROM products;
SELECT 'CUSTOMER TEST: FAIL SELECT orders' AS test, 
  (SELECT COUNT(*) FROM orders) AS attempt;