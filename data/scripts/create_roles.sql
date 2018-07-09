-- Creating and configuring roles (2)
CREATE ROLE clerk; -- ATENDENTE
GRANT SELECT, INSERT, UPDATE ON BOCATO.clerk_product TO clerk; -- Atualização de permisões
GRANT SELECT, INSERT, UPDATE ON BOCATO.clerk_storage TO clerk; -- Atualização de permisões
GRANT SELECT ON BOCATO.PRODUCT_SEQ TO clerk;

CREATE ROLE manager; -- GERENTE
GRANT INSERT, UPDATE, SELECT, DELETE ON BOCATO.product to manager;
GRANT INSERT, UPDATE, SELECT, DELETE ON BOCATO.storage to manager;
GRANT SELECT ON BOCATO.PRODUCT_SEQ TO manager;

COMMIT;
