require_relative '../../lib/crud_data'

class Product < CRUDData
  def initialize(conn)
    @conn = conn
  end


  # INSERT INTO CLERK_PRODUCT ( ID, DESCRIPTION, PRICE) VALUES ( :1, :2, :3);
  #
  # UPDATE CLERK_PRODUCT SET ID = :1, DESCRIPTION = :2, PRICE = :3 WHERE ID = :1;
  #
  # DELETE FROM CLERK_PRODUCT WHERE ID = 1;
  #
  # INSERT INTO CLERK_STORAGE ( PRODUCT_ID, QUANTITY) VALUES ( 1, 1);
  #
  # UPDATE CLERK_STORAGE SET PRODUCT_ID = :1, QUANTITY = :2 WHERE PRODUCT_ID = :1;
  #
  # DELETE FROM CLERK_STORAGE WHERE PRODUCT_ID = 1;


  def create_product(received_hash)
    id = check_if_data_is_valid(received_hash, :id)
    description = check_if_data_is_valid(received_hash, :description)
    price = check_if_data_is_valid(received_hash, :price)

    puts "Creating a CLERK Product #{name}"
    # TODO: CHECK QUERY
    insert_sql = 'INSERT INTO CLERK_PRODUCT ( ID, DESCRIPTION, PRICE) VALUES ( :1, :2, :3);'
    insert_stmt = @conn.prepare_statement(insert_sql)
    insert_stmt.set_int 1, id
    insert_stmt.set_string 2, description
    insert_stmt.set_float 3, price
    insert_stmt.execute
    @conn.commit

  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    insert_stmt.close unless insert_stmt.nil?
  end

  def read_product(id)
    # TODO: CHECK QUERY
    query_part = if id.nil?
                   "WHERE ID=#{id}"
                 else
                   ''
                 end

    select_sql = "select * from CLERK_PRODUCT #{query_part}"
    select_stmt = @conn.create_statement
    rset = select_stmt.execute_query select_sql
    while rset.next
      puts "    CLERK PRODUCT [#{rset}]"
    end
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    rset.close unless rset.nil?
    select_stmt.close unless select_stmt.nil?
  end

  def update_product(received_hash)
    id = check_if_data_is_valid(received_hash, :id)
    description = check_if_data_is_valid(received_hash, :description)
    price = check_if_data_is_valid(received_hash, :price)

    # TODO: CHECK QUERY
    sql_query = 'UPDATE CLERK_PRODUCT SET ID = :1, DESCRIPTION = :2, PRICE = :3 WHERE ID = :1;'
    query_stmt = @conn.prepare_statement(sql_query)
    query_stmt.set_int 1, id
    query_stmt.set_string 2, description
    query_stmt.set_float 3, price
    query_stmt.execute
    @conn.commit
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    query_stmt.close unless query_stmt.nil?
  end

  def delete_product(received_id)
    # TODO: CHECK QUERY
    delete_stmt = conn.prepare_statement 'DELETE FROM CLERK_PRODUCT WHERE ID = :1;'
    delete_stmt.set_int 1, received_id
    delete_stmt.execute_update
    @conn.commit
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    delete_stmt.close unless delete_stmt.nil?
  end

  def create_storage(received_hash)
    product_id = check_if_data_is_valid(received_hash, :product_id)
    quantity = check_if_data_is_valid(received_hash, :quantity)
    seller = check_if_data_is_valid(received_hash, :seller)

    puts "Creating a CLERK Storage #{name}"
    # TODO: CHECK QUERY
    insert_sql = 'INSERT INTO CLERK_STORAGE ( PRODUCT_ID, QUANTITY) VALUES ( :1, :2);'
    insert_stmt = @conn.prepare_statement(insert_sql)
    insert_stmt.set_int 1, product_id
    insert_stmt.set_int 2, quantity
    insert_stmt.set_string 3, seller
    insert_stmt.execute
    @conn.commit

  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    insert_stmt.close unless insert_stmt.nil?
  end

  def read_storage(id)
    # TODO: CHECK QUERY
    query_part = if id.nil?
                   "WHERE PRODUCT_ID=#{id}"
                 else
                   ''
                 end

    select_sql = "select * from CLERK_STORAGE #{query_part}"
    select_stmt = @conn.create_statement
    rset = select_stmt.execute_query select_sql
    while rset.next
      puts "    CLERK STORAGE [#{rset}]"
    end
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    rset.close unless rset.nil?
    select_stmt.close unless select_stmt.nil?
  end

  def update_storage(received_hash)
    product_id = check_if_data_is_valid(received_hash, :product_id)
    quantity = check_if_data_is_valid(received_hash, :quantity)
    seller = check_if_data_is_valid(received_hash, :seller)

    # TODO: CHECK QUERY
    sql_query = 'UPDATE CLERK_STORAGE SET PRODUCT_ID = :1, QUANTITY = :2 WHERE PRODUCT_ID = :1;'
    query_stmt = @conn.prepare_statement(sql_query)
    query_stmt.set_int 1, product_id
    query_stmt.set_int 2, quantity
    query_stmt.set_string 3, seller
    query_stmt.execute
    @conn.commit
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    query_stmt.close unless query_stmt.nil?
  end

  def delete_storage(received_id)
    # TODO: CHECK QUERY
    delete_stmt = conn.prepare_statement 'DELETE FROM CLERK_STORAGE WHERE PRODUCT_ID = :1;'
    delete_stmt.set_int 1, received_id
    delete_stmt.execute_update
    @conn.commit
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    delete_stmt.close unless delete_stmt.nil?
  end
end
