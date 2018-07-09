-- Creating and configuring roles (2)
CREATE ROLE clerk; -- ATENDENTE
GRANT SELECT, INSERT, UPDATE ON BD2.clerk_product TO clerk; -- Atualização de permisões
GRANT SELECT, INSERT, UPDATE ON BD2.clerk_storage TO clerk; -- Atualização de permisões
GRANT SELECT ON BD2.PRODUCT_SEQ TO clerk;

CREATE ROLE manager; -- GERENTE
GRANT INSERT, UPDATE, SELECT, DELETE ON BD2.product to manager;
GRANT INSERT, UPDATE, SELECT, DELETE ON BD2.storage to manager;
GRANT SELECT ON BD2.PRODUCT_SEQ TO manager;

COMMIT;
