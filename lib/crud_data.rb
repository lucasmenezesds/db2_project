class CRUDData

  def check_if_data_is_valid(received_hash, key)
    fetched_data = received_hash.fetch(key, nil)

    if fetched_data.nil?
      throw "It's missing data"
    end
    fetched_data
  end

  # TODO: ver como que vou fazer pra checar
  def check_permission(user_type)

  end

  def get_current_permissions

  end


end