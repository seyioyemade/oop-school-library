# Save to database
class AppSaveDatabase
  # def initialize()
  #   super()

  # end
  def save_books(app)
    updated_books = []
    app.books.each do |book|
      updated_books << { 'title' => book.title, 'author' => book.author }
    end
    File.write('data/books.json', JSON.pretty_generate(updated_books))
  end

  def save_rentals(app)
    updated_rentals = []

    app.rentals.each do |rental|
      updated_rentals << { 'person_name' => rental.person.name, 'book_titles' => rental.book.title,
                           'date' => rental.date }
    end

    File.write('data/rentals.json', JSON.pretty_generate(updated_rentals))
  end
end
