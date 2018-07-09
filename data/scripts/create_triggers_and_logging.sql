-- Create system log table (5)
CREATE TABLE system_logs (
  log_date     VARCHAR(30),
  current_user VARCHAR(30),
  table_name   VARCHAR(30),
  operation    VARCHAR(30),
  old_values   VARCHAR(255),
  new_values   VARCHAR(255)
);

-- Trigger to log user actions
CREATE OR REPLACE TRIGGER audit_product_table
BEFORE INSERT OR DELETE OR UPDATE ON PRODUCT
REFERENCING NEW AS NEW_VALUE OLD AS OLD_VALUE
FOR EACH ROW
  DECLARE
    system_date VARCHAR(30);
    username VARCHAR(30);
    old_value VARCHAR(255);
    new_value VARCHAR(255);
    current_operation VARCHAR(30);
  BEGIN

    -- Select users and date
    SELECT user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO username, system_date FROM dual;

    -- Define operation, check new values and ond values
    IF INSERTING THEN
      current_operation := 'INSERT';
      new_value := :NEW_VALUE.ID || ',' || :NEW_VALUE.DESCRIPTION || ',' || :NEW_VALUE.PRICE || ',' || :NEW_VALUE.COST;
      old_value := '';
    END IF;

    IF UPDATING THEN
      current_operation := 'UPDATE';
      new_value := :NEW_VALUE.ID || ',' || :NEW_VALUE.DESCRIPTION || ',' || :NEW_VALUE.PRICE || ',' || :NEW_VALUE.COST;
      old_value := :OLD_VALUE.ID || ',' || :OLD_VALUE.DESCRIPTION || ',' || :OLD_VALUE.PRICE || ',' || :OLD_VALUE.COST;
    END IF;

    IF DELETING THEN
      current_operation := 'DELETE';
      new_value := '';
      old_value := :OLD_VALUE.ID || ',' || :OLD_VALUE.DESCRIPTION || ',' || :OLD_VALUE.PRICE || ',' || :OLD_VALUE.COST;
    END IF;

    -- Insert on table
    INSERT INTO SYSTEM_LOGS(log_date, current_user, table_name, operation, old_values, new_values) VALUES (
      system_date,
      username,
      'PRODUCT',
      current_operation,
      old_value,
      new_value
    );

  END;

CREATE OR REPLACE TRIGGER audit_storage_table
BEFORE INSERT OR DELETE OR UPDATE ON STORAGE
REFERENCING NEW AS NEW_VALUE OLD AS OLD_VALUE
FOR EACH ROW
  DECLARE
    system_date VARCHAR(30);
    username VARCHAR(30);
    old_value VARCHAR(255);
    new_value VARCHAR(255);
    current_operation VARCHAR(30);
  BEGIN

    -- Select users and date
    SELECT user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO username, system_date FROM dual;

    -- Define operation, check new values and ond values
    IF INSERTING THEN
      current_operation := 'INSERT';
      new_value := :NEW_VALUE.PRODUCT_ID || ',' || :NEW_VALUE.QUANTITY || ',' || :NEW_VALUE.SELLER;
      old_value := '';
    END IF;

    IF UPDATING THEN
      current_operation := 'UPDATE';
      new_value := :NEW_VALUE.PRODUCT_ID || ',' || :NEW_VALUE.QUANTITY || ',' || :NEW_VALUE.SELLER;
      old_value := :OLD_VALUE.PRODUCT_ID || ',' || :OLD_VALUE.QUANTITY || ',' || :OLD_VALUE.SELLER;
    END IF;

    IF DELETING THEN
      current_operation := 'DELETE';
      new_value := '';
      old_value := :OLD_VALUE.PRODUCT_ID || ',' || :OLD_VALUE.QUANTITY || ',' || :OLD_VALUE.SELLER;
    END IF;

    -- Insert on table
    INSERT INTO SYSTEM_LOGS(log_date, current_user, table_name, operation, old_values, new_values) VALUES (
      system_date,
      username,
      'PRODUCT',
      current_operation,
      old_value,
      new_value
    );

  END;