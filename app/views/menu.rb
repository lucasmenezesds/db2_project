require 'tty-prompt'

# Menu Class
class Menu
  def initialize
    @prompt = TTY::Prompt.new
  end

  def show_welcome
    puts '########################'
    puts 'Welcome, to DB 2 Project'
    puts '########################'
    puts ''
  end

  def show_farewell
    puts ''
    puts '####################'
    puts 'Ok! See you latter!'
    puts '####################'
    puts ''
  end

  def loop_of_actions
    @prompt.select('What do you want to work with?') do |menu|
      # menu.choice 'Auditing', :audit
      menu.choice 'Products', :product
      menu.choice 'Storage', :storage
      menu.choice 'Clerk Actions', :clerk
      # menu.choice 'Users', :user
      menu.choice 'Quit', :quit
    end
  end

  def show_crud_options(option)
    @prompt.select("About the #{option}... Choose what you want to do..") do |menu|
      menu.choice 'Create Data', :create
      menu.choice 'Read Data', :read
      menu.choice 'Update Data', :update
      menu.choice 'Delete Data', :delete
    end
  end

  def show_clerk_crud_options(option)
    @prompt.select("About the #{option}... Choose what you want to do..") do |menu|
      menu.choice 'Create Clerk Product', :create_product
      menu.choice 'Read Clerk Product', :read_product
      menu.choice 'Update Clerk Product', :update_product
      menu.choice 'Delete Clerk Product', :delete_product
      menu.choice 'Create Clerk Storage', :create_storage
      menu.choice 'Read Clerk Storage', :read_storage
      menu.choice 'Update Clerk Storage', :update_storage
      menu.choice 'Delete Clerk Storage', :delete_storage
    end
  end

  def ask_storage_data
    @prompt.collect do
      key(:seller).ask('Seller?', default: 'Standart_Seller')
      key(:product_id).ask('Product ID?', convert: :int)
      key(:quantity).ask('Quantity?', convert: :int)
    end
  end
  def ask_storage_data_clerk
    @prompt.collect do
      key(:product_id).ask('Product ID?', convert: :int)
      key(:quantity).ask('Quantity?', convert: :int)
    end
  end

  def ask_storage_product_id
    @prompt.collect do
      key(:product_id).ask('Product ID?', convert: :int)
    end
  end

  def ask_product_data
    @prompt.collect do
      key(:id).ask('Product ID?', convert: :int)
      key(:description).ask('Description?')
      key(:price).ask('Price?', convert: :float)
      key(:cost).ask('Cost?', convert: :float)
    end
  end

  def ask_product_data_clerk
    @prompt.collect do
      key(:id).ask('Product ID?', convert: :int)
      key(:description).ask('Description?')
      key(:price).ask('Price?', convert: :float)
    end
  end

  def ask_product_id
    @prompt.collect do
      key(:id).ask('Product ID?', convert: :int)
    end
  end

  def get_login_auth
    user = ask_user
    pwd = ask_password
    { user: user, password: pwd }
  end

  def ask_user
    @prompt.ask('Type your user', default: 'the_manager')
  end

  def ask_password
    @prompt.mask('Type your Password')
  end

end