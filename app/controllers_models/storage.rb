require_relative '../../lib/crud_data'

class Storage < CRUDData

  def initialize(conn, current_user)
    @conn = conn
    @current_user = current_user
  end

  def create(received_hash)
    user_type = check_if_data_is_valid(received_hash, :user_type)
    # check_permission(user_type)
    name = check_if_data_is_valid(received_hash, :name)
    password = check_if_data_is_valid(received_hash, :password)

    puts "Creating the User #{name}"
    # TODO: Query atualizada verificar que as informações estão sendo enviadas corretamente :1 = Usuario, :2 = Perfil, :3 = Senha.
    insert_sql = 'create user :1 identified by :2'
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

  def read(name)
    # check_permission(@conn, @current_user, role)

    # TODO: Query atualizada tinha uma virgula fora do lugar
    query_part = if name.nil?
                   add_username_to_query(name)
                 else
                   ''
                 end

    select_sql = "select USERNAME from dba_users #{query_part}"
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
    # TODO: Query atualizada verificar que as informações estão sendo enviadas corretamente :1 = Usuario :2 = Perfil :3 = Senha
    sql_query = 'alter user :1 identified by :3 profile :2'
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

  def delete(received_id)
    # TODO: Query atualizada
    delete_stmt = conn.prepare_call 'drop user :1'
    delete_stmt.set_int 1, received_id
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
