require_relative '../../app/views/menu'
require_relative 'audit'
require_relative 'product'
require_relative 'storage'
require_relative 'user'

class ConvenienceFlow

  def initialize(conn)
    @conn = conn
    @menu = Menu.new
  end

  def run_it(received_action)

    case received_action
    when :audit
      puts 'audit'
    when :product
      product_steps
    when :storage
      storage_steps
    when :user
      puts 'user'
    when :clerk
      clerk_steps
    when :quit
      puts 'quit'
    else
      puts 'quit'
    end
  end

  # def audit_steps
  #   option = @menu.show_crud_options('Audit')
  # end

  def product_steps
    product_obj = Product.new(@conn)
    case @menu.show_crud_options('Product')
    when :create
      product_obj.create(@menu.ask_product_data)
    when :read
      id = @menu.ask_product_id[:id]
      product_obj.read(id)
    when :update
      product_obj.update(@menu.ask_product_data)
    when :delete
      id = @menu.ask_product_id[:id]
      product_obj.delete(id)
    end
  end

  def storage_steps
    storage_obj = Product.new(@conn)
    case @menu.show_crud_options('Storage')
    when :create
      storage_obj.create(@menu.ask_storage_data)
    when :read
      id = ask_storage_product_id[:product_id]
      storage_obj.read(id)
    when :update
      storage_obj.update(@menu.ask_storage_data)
    when :delete
      id = @menu.ask_storage_product_id[:product_id]
      storage_obj.delete(id)
    end
  end

  def clerk_steps
    clerk_obj = ClerkCrud.new(@conn)
    case @menu.show_clerk_crud_options('Clerk Storage or Clerk Product')
    when :create_storage
      clerk_obj.create_storage(@menu.ask_storage_data_clerk)
    when :read_storage
      id = ask_storage_product_id[:product_id]
      clerk_obj.read_storage(id)
    when :update_storage
      clerk_obj.update_storage(@menu.ask_storage_data_clerk)
    when :delete_storage
      id = @menu.ask_storage_product_id[:product_id]
      clerk_obj.delete_storage(id)
    when :create_product
      clerk_obj.create_product(@menu.ask_product_data_clerk)
    when :read_product
      id = @menu.ask_product_id[:id]
      clerk_obj.read(id)
    when :update_product
      clerk_obj.update_product(@menu.ask_product_data_clerk)
    when :delete_product
      id = @menu.ask_product_id[:id]
      clerk_obj.delete_product(id)
    end
  end
end