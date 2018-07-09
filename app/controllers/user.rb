require_relative '../../lib/crud_data'
require_relative '../../app/models/db_connector'

class User < CRUDData

  def initialize(conn, current_user)
    @conn = conn
    @current_user = current_user
  end

  def create(received_hash)
    user_type = check_if_data_is_valid(received_hash, :user_type)
    check_permission(user_type)
    name = check_if_data_is_valid(received_hash, :name)
    password = check_if_data_is_valid(received_hash, :password)

    puts "Creating the User #{name}"
    # TODO: FIX QUERY
    insert_sql = 'insert into departments values (:1, :2, NULL, NULL)'
    insert_stmt = @conn.prepare_statement(insert_sql)
    insert_stmt.set_string 1, name
    insert_stmt.set_string 2, password
    insert_stmt.execute
    @conn.commit

  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    insert_stmt.close unless insert_stmt.nil?
  end

  def read(name, user_type)
    check_permission(user_type)

    # TODO: CHECK QUERY
    query_part = if name.nil?
                   add_username_to_query(name)
                 else
                   ''
                 end

    select_sql = "select USERNAME, from dba_users #{query_part}"
    select_stmt = @conn.create_statement
    rset = select_stmt.execute_query select_sql
    while rset.next
      puts "    USER [#{rset.getInt(1)}"
    end
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    rset.close unless rset.nil?
    select_stmt.close unless select_stmt.nil?
  end

  def update(username, role)
    # TODO: FIX QUERY
    sql_query = 'insert into departments values (:1, :2, NULL, NULL)'
    query_stmt = @conn.prepare_statement(sql_query)
    query_stmt.set_string 1, username
    query_stmt.set_string 2, role
    query_stmt.execute
    @conn.commit
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    query_stmt.close unless query_stmt.nil?
  end

  def delete

    # Helpers to call our PL/SQL package
    # PLSQL_BLOCK_FUNCTION_CALL = <<EOF
    #   begin
    #     :1 := emp_pack.get_employee_name(:2);
    #   end;
    # EOF
    #
    #
    # PLSQL_BLOCK_PROCEDURE_CALL = <<EOF
    #   begin
    #     emp_pack.delete_department(:1);
    #   end;
    # EOF

    # TODO: FIX QUERY
    puts '4. Deleting department 281 from the DEPARTMENTS table'
    delete_stmt = conn.prepare_call PLSQL_BLOCK_PROCEDURE_CALL
    delete_stmt.set_int 1, 281
    delete_stmt.execute_update
    @conn.commit
  rescue
    puts "\n** Error occured **\n"
    puts 'Failed executing the command ', $!, '---------'
  ensure
    delete_stmt.close unless delete_stmt.nil?
  end

  private

  def add_username_to_query(username)
    "USERNAME=#{username}"
  end

  # def add_user_type_to_query(user_type)
  #   "GRANTED_ROLE = #{user_type}"
  # end
  #
  # def add_params_to_query(username, user_type)
  #   username_query = add_username_to_query(username)
  #   user_type_query = add_user_type_to_query(user_type)
  #   "#{username_query} AND #{user_type_query}"
  # end
end