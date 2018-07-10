require 'active_record'
require_relative '../app/views/menu'
require_relative '../lib/jdbc_connection'
require_relative '../app/controllers_models/convenience_flow'

begin
  db_config = YAML::load(File.open('config/database.yml'))

  url = "#{db_config['adapter']}:#{db_config['driver']}:thin:@#{db_config['hostname']}:#{db_config['port']}:#{db_config['database']}"

  menu = Menu.new
  menu.show_welcome
  login_data = menu.get_login_auth

  user = login_data[:user]
  passwd = login_data[:password]

  conn = OracleConnection.create(user, passwd, url)
  # puts conn.inspect
  conn.change_schema('BD2')

  loop do
    action = menu.loop_of_actions
    break if action == :quit
    conv_flow = ConvenienceFlow.new(conn)
    conv_flow.run_it(action)
  end

  menu.show_farewell
rescue
  puts "\n** Error occured **\n"
  puts 'Failed executing the command ', $!, '---------'
ensure
  conn.close_connection unless conn.nil?
end
