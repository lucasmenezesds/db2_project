-- Creating tables (1)
CREATE TABLE product (
  id DECIMAL(13) NOT NULL,
  description VARCHAR(255) NOT NULL,
  price FLOAT,
  cost FLOAT DEFAULT 0.0, -- Adicionado default para fazer inserts na tabela via View
  PRIMARY KEY (id)
);

CREATE SEQUENCE product_seq START WITH 1;

CREATE TABLE storage (
  product_id DECIMAL(13) NOT NULL,
  quantity INTEGER NOT NULL,
  seller VARCHAR(255) DEFAULT 'Standart_Seller' NOT NULL,
  FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
);

CREATE VIEW clerk_product AS
  SELECT id, description, price
  FROM product;

CREATE VIEW clerk_storage AS
  SELECT product_id, quantity
  FROM storage;

COMMIT;
