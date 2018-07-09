class CRUDData

  # TODO: check it
  def check_if_data_is_valid(received_hash, key)
    fetched_data = received_hash.fetch(key, nil)

    if fetched_data.nil?
      throw "It's missing data"
    end
    fetched_data
  end

  # TODO: ver como que vou fazer pra checar
  # SELECT * FROM DBA_TAB_PRIVS; checa privilegios de usuario.
  # SELECT * FROM DBA_ROLE_PRIVS; checa privilegios de perfil.
  def check_permission(user_type)
    user_type
  end

  def get_current_permissions
    1
  end


end
