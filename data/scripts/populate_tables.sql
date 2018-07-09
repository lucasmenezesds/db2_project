-- Insert data on product (4)
INSERT INTO product VALUES (PRODUCT_SEQ.nextval, 'Product 1', 1.11, 0.11);
INSERT INTO product VALUES (PRODUCT_SEQ.nextval, 'Product 2', 2.22, 0.22);
INSERT INTO product VALUES (PRODUCT_SEQ.nextval, 'Product 3', 3.33, 0.33);
INSERT INTO product VALUES (PRODUCT_SEQ.nextval, 'Product 4', 4.44, 0.44);
INSERT INTO product VALUES (PRODUCT_SEQ.nextval, 'Product 5', 5.55, 0.55);
INSERT INTO product VALUES (PRODUCT_SEQ.nextval, 'Product 6', 6.66, 0.66);
INSERT INTO product VALUES (PRODUCT_SEQ.nextval, 'Product 7', 7.77, 0.77);
INSERT INTO product VALUES (PRODUCT_SEQ.nextval, 'Product 8', 8.88, 0.88);
INSERT INTO product VALUES (PRODUCT_SEQ.nextval, 'Product 9', 9.99, 0.99);

-- Insert data on storage
INSERT INTO storage VALUES (1, 11, 'Factory 1');
INSERT INTO storage VALUES (2, 22, 'Factory 2');
INSERT INTO storage VALUES (3, 33, 'Factory 1');
INSERT INTO storage VALUES (4, 44, 'Factory 2');
INSERT INTO storage VALUES (5, 55, 'Factory 1');
INSERT INTO storage VALUES (6, 66, 'Factory 2');
INSERT INTO storage VALUES (7, 77, 'Factory 1');
INSERT INTO storage VALUES (8, 88, 'Factory 2');
INSERT INTO storage VALUES (9, 99, 'Factory 1');

COMMIT;