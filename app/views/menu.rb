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
      menu.choice 'Auditing', :audit
      menu.choice 'Products', :product
      menu.choice 'Purchases', :purchase
      menu.choice 'Users', :user
      menu.choise 'Quit', :quit
    end
  end

  def show_crud_options
    @prompt.select('Choose what you want to do..') do |menu|
      menu.choice 'Create Data'
      menu.choice 'Remove Data'
      menu.choice 'Update Data'
      menu.choice 'Delete Data'
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