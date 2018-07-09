# Parent Class
class CRUDData

  # TODO: check it
  def check_if_data_is_valid(received_hash, key)
    fetched_data = received_hash.fetch(key, nil)
    throw "It's missing data" if fetched_data.nil?
    fetched_data
  end

  # SELECT * FROM DBA_TAB_PRIVS; checa privilegios de usuario.
  # SELECT * FROM DBA_ROLE_PRIVS; checa privilegios de perfil.
  def check_permission(conn, username, role)

    select_sql = "select * from DBA_ROLE_PRIVS where GRANTEE='#{username}' and GRANTED_ROLE='#{role}'"
    select_stmt = conn.create_statement
    response = select_stmt.execute_query select_sql

    throw 'User dont have permission for this action' if response.empty?
  end

end
