#!/usr/bin/env ruby
require_relative 'app'
require_relative 'app_logic'
require_relative 'app_save_database'

def main
  app = App.new
  app.load_data
  app_logic = AppLogic.new
  app_save_database = AppSaveDatabase.new
  puts "Welcome to the School Library App!\n\n"

  loop do
    app_logic.menu
    option = gets.chomp.to_i
    app_logic.options(option, app)
    app_save_database.save_books(app)
    app.save_people
    app_save_database.save_rentals(app)
  end
end

main
