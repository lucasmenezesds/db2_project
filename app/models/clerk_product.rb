class ClerkProduct

  def initialize(conn)
    @conn = conn
  end

  def create(received_hash)
    product_id = check_if_data_is_valid(received_hash, :product_id)
    quantity = check_if_data_is_valid(received_hash, :quantity)
    seller = check_if_data_is_valid(received_hash, :seller)

    puts "Creating a CLERK Storage #{product_id}"
    # TODO: CHECK QUERY
    insert_sql = 'INSERT INTO CLERK_STORAGE ( PRODUCT_ID, QUANTITY) VALUES ( :1, :2)'
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

  def read(id)
    # TODO: CHECK QUERY
    query_part = if id.nil?
                   ''
                 else
                   "WHERE PRODUCT_ID=#{id}"
                 end

    select_sql = "select * from CLERK_STORAGE #{query_part}"
    select_stmt = @conn.create_statement
    rset = select_stmt.execute_query select_sql
    while rset.next
      puts "    CLERK STORAGE [PRODUCT_ID: #{rset.getString(1)}, QUANTITY: #{rset.getString(2)}, SELLER: #{rset.getString(3)}]"
    end
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    rset.close unless rset.nil?
    select_stmt.close unless select_stmt.nil?
  end

  def update(received_hash)
    product_id = check_if_data_is_valid(received_hash, :product_id)
    quantity = check_if_data_is_valid(received_hash, :quantity)
    seller = check_if_data_is_valid(received_hash, :seller)

    # TODO: CHECK QUERY
    sql_query = 'UPDATE CLERK_STORAGE SET PRODUCT_ID = :1, QUANTITY = :2 WHERE PRODUCT_ID = :1'
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

  def delete(received_id)
    # TODO: CHECK QUERY
    delete_stmt = conn.prepare_statement 'DELETE FROM CLERK_STORAGE WHERE PRODUCT_ID = :1'
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