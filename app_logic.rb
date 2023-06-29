class AppLogic
  def options(option, app)
    actions = {
      1 => :create_book,
      2 => :list_all_books,
      3 => :create_person,
      4 => :list_all_people,
      5 => :add_rental,
      6 => :list_all_rentals,
      7 => :exit!
    }

    action = actions[option]

    if action
      app.send(action)
    else
      puts 'Invalid selection'
    end
  end

  def menu
    puts '
      1 - Add a book
      2 - Show all books
      3 - Add a person
      4 - Show all people
      5 - Add a rental
      6 - Show all rentals for a given ID
      7 - Exit
    '
  end
end
