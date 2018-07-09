require_relative '../../lib/crud_data'

class Product < CRUDData
  def initialize(conn)
    @conn = conn
  end

  def create(received_hash)
    id = check_if_data_is_valid(received_hash, :id)
    description = check_if_data_is_valid(received_hash, :description)
    price = check_if_data_is_valid(received_hash, :price)
    cost = check_if_data_is_valid(received_hash, :cost)

    puts "Creating a Product #{name}"
    # TODO: CHECK QUERY
    insert_sql = 'INSERT INTO PRODUCT ( ID, DESCRIPTION, PRICE, COST) VALUES ( :1, :2, :3, :4);'
    insert_stmt = @conn.prepare_statement(insert_sql)
    insert_stmt.set_int 1, id
    insert_stmt.set_string 2, description
    insert_stmt.set_float 3, price
    insert_stmt.set_float 4, cost
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
                   "WHERE ID=#{id}"
                 else
                   ''
                 end

    select_sql = "select * from product #{query_part}"
    select_stmt = @conn.create_statement
    rset = select_stmt.execute_query select_sql
    while rset.next
      puts "    PRODUCT [#{rset}]"
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
    cost = check_if_data_is_valid(received_hash, :cost)

    # TODO: CHECK QUERY
    sql_query = 'UPDATE PRODUCT SET ID = :1 DESCRIPTION = :2,PRICE = :3,COST = :4 WHERE ID = :1;'
    query_stmt = @conn.prepare_statement(sql_query)
    query_stmt.set_int 1, id
    query_stmt.set_string 2, description
    query_stmt.set_float 3, price
    query_stmt.set_float 4, cost
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
    delete_stmt = conn.prepare_statement 'DELETE FROM PRODUCT WHERE ID = :1;'
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
