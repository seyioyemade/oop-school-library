#!/usr/bin/env ruby
require_relative 'app'
require_relative 'app_logic'

def main
  app = App.new
  app.load_data
  app_logic = AppLogic.new
  puts "Welcome to the School Library App!\n\n"

  loop do
    puts '
      1 - Add a book
      2 - Show all books
      3 - Add a person
      4 - Show all people
      5 - Add a rental
      6 - Show all rentals for a given ID
      7 - Exit
    '
    option = gets.chomp.to_i
    app.save_books
    app.save_people
    app.save_rentals
    app_logic.options(option, app)
  end
end

main
