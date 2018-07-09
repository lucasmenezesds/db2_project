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
      puts 'product'
    when :storage
      puts 'storage'
    when :user
      puts 'user'
    when :quit
      puts 'quit'
    else
      puts 'quit'
    end
  end

  def audit_steps
    option = @menu.show_crud_options('Audit')
  end

  def product_steps
    option = @menu.ask_product_data
    product_obj = Product.new(@conn)
  end
end