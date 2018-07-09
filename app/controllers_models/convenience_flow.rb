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
      puts 'clerk'
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
      id = @menu.ask_product_data[:id]
      product_obj.read(id)
    when :update
      product_obj.update(@menu.ask_product_data)
    when :delete
      id = @menu.ask_product_data[:id]
      product_obj.delete(id)
    end
  end

  def storage_steps
    storage_obj = Product.new(@conn)
    case @menu.show_crud_options('Storage')
    when :create
      storage_obj.create(@menu.ask_storage_data)
    when :read
      id = @menu.ask_storage_data[:product_id]
      storage_obj.read(id)
    when :update
      storage_obj.update(@menu.ask_storage_data)
    when :delete
      id = @menu.ask_storage_data[:product_id]
      storage_obj.delete(id)
    end
  end
end