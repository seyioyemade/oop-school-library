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
end
