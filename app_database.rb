# Save to database
require_relative 'app'

class AppDatabase < App
  attr_accessor :person, :books, :rentals

  def save_books
    updated_books = []
    @books.each do |book|
      updated_books << { 'title' => book.title, 'author' => book.author }
    end
    File.write('data/books.json', JSON.pretty_generate(updated_books))
  end

  def save_people
    updated_people = []
    @people.each do |person|
      if person.instance_of?(::Teacher)
        updated_people << { 'class' => 'Teacher', 'id' => person.id, 'name' => person.name, 'age' => person.age,
                            'specialization' => person.specialization }
      elsif person.instance_of?(::Student)
        updated_people << { 'class' => 'Student', 'id' => person.id, 'name' => person.name, 'age' => person.age,
                            'parent_permission' => person.parent_permission }
      end
    end

    File.write('data/people.json', JSON.pretty_generate(updated_people))
  end

  def save_rentals
    updated_rentals = []

    @rentals.each do |rental|
      updated_rentals << { 'person_name' => rental.person.name, 'book_titles' => rental.book.title,
                           'date' => rental.date }
    end

    File.write('data/rentals.json', JSON.pretty_generate(updated_rentals))
  end
end
