class ClerkStorage
  def initialize(conn)
    @conn = conn
  end

  def create(received_hash)
    id = check_if_data_is_valid(received_hash, :id)
    description = check_if_data_is_valid(received_hash, :description)
    price = check_if_data_is_valid(received_hash, :price)

    puts "Creating a CLERK Product #{id}"
    # TODO: CHECK QUERY
    insert_sql = 'INSERT INTO CLERK ( ID, DESCRIPTION, PRICE) VALUES ( :1, :2, :3)'
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

  def read(id)
    # TODO: CHECK QUERY
    query_part = if id.nil?
                   ''
                 else
                   "WHERE ID=#{id}"
                 end

    select_sql = "select * from CLERK #{query_part}"
    select_stmt = @conn.create_statement
    rset = select_stmt.execute_query select_sql
    while rset.next
      puts "    CLERK PRODUCT [ID: #{rset.getString(1)}, NAME: #{rset.getString(2)}, PRICE:#{rset.getString(3)}, COST: #{rset.getString(4)}]"
    end
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    rset.close unless rset.nil?
    select_stmt.close unless select_stmt.nil?
  end

  def update(received_hash)
    id = check_if_data_is_valid(received_hash, :id)
    description = check_if_data_is_valid(received_hash, :description)
    price = check_if_data_is_valid(received_hash, :price)

    # TODO: CHECK QUERY
    sql_query = 'UPDATE CLERK_PRODUCT SET ID = :1, DESCRIPTION = :2, PRICE = :3 WHERE ID = :1'
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

  def delete(received_id)
    # TODO: CHECK QUERY
    delete_stmt = conn.prepare_statement 'DELETE FROM CLERK_PRODUCT WHERE ID = :1'
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