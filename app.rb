require_relative 'person'
require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require 'json'

class App
  attr_accessor :person, :books, :rentals

  def initialize()
    @people = []
    @books = []
    @rentals = []
  end
  # Load data from database

  def fetch_data(file)
    if File.exist?("data/#{file}.json")
      File.read("data/#{file}.json")
    else
      empty_json = [].to_json
      File.write("data/#{file}.json", empty_json)
      empty_json
    end
  end

  def load_data
    books = JSON.parse(fetch_data('books'))
    people = JSON.parse(fetch_data('people'))
    rentals = JSON.parse(fetch_data('rentals'))

    books.each do |book|
      @books << Book.new(book['title'], book['author'])
    end

    people.each do |person|
      @people << if person['class'] == 'Teacher'
                   Teacher.new(person['age'], person['specialization'], person['name'])
                 else
                   Student.new(person['age'], 1, person['parent_permission'], person['name'])
                 end
    end

    rentals.each do |rental|
      rentee = @people.select { |person| person.name == rental['person_name'] }
      rented_book = @books.select { |book| book.title == rental['book_titles'] }
      @rentals << Rental.new(rental['date'], rented_book[0], rentee[0])
    end
  end

  # UIs

  def create_book
    puts ''
    print 'Enter book title: '
    title = gets.chomp
    print 'Enter book author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Success'
  end

  def list_all_books
    puts ''
    @books.each { |book| puts "Title: #{book.title}", "Author: #{book.author}" }
  end

  def create_person
    puts ''
    print 'Enter 1 to add Student and 2 to add Teacher: '
    selection = gets.chomp.to_i
    print 'Enter name: '
    name = gets.chomp
    print 'Enter age: '
    age = gets.chomp.to_i

    case selection
    when 1
      print 'Does student have parent permission [Y/N]: '
      permission = gets.chomp.downcase == 'y'
      student = Student.new(age, 1, permission, name)
      @people << student

    when 2
      print 'What is the teachers specialization: '
      specialization = gets.chomp
      teacher = Teacher.new(age, specialization, name)
      @people << teacher
    end

    print 'Success'
  end

  def list_all_people
    puts ''
    @people.each do |person|
      puts ''
      puts "[#{person.class}]"
      puts "Name: #{person.name}"
      puts "ID: #{person.id}"
      puts "Age: #{person.age}"

      if person.instance_of?(Teacher)
        puts "Specialization: #{person.specialization}"
      else
        puts "Permission: #{person.parent_permission}"
      end
    end
  end

  def add_rental
    puts ''
    puts 'Select a book from below by number: '

    @books.each_with_index { |book, index| puts "(#{index}) Title: #{book.title}, Author: #{book.author}" }
    puts ''
    book_num = gets.chomp.to_i
    puts ''

    puts 'Select a person from below by number : '
    @people.each_with_index do |person, index|
      puts "(#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts ''
    person_num = gets.chomp.to_i
    puts ''

    print 'Date(yyyy/mm/dd): '
    date = gets.chomp

    rental = Rental.new(date, @books[book_num], @people[person_num])
    @rentals << rental
    puts ''
    puts 'Success'
  end

  def list_all_rentals
    puts ''
    puts 'All ID\'s:'
    @rentals.each do |rental|
      puts rental.person.id if rental.person.id
    end
    puts ''

    print 'Please select an ID to show more details: '
    id = gets.chomp.to_i
    puts ''

    puts 'Rental(s) for this ID: '
    @rentals.each do |rental|
      if rental.person.id == id
        puts "Date: #{rental.date} Book: #{rental.book.title} by #{rental.book.author}"
      else
        puts 'Person does not exist'
      end
    end
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
end
