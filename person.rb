require './nameable'

class Person < Nameable
  attr_reader :id, :parent_permission, :rentals
  attr_accessor :name, :age

  def initialize(age, parent_permission, name = 'Unknown')
    super()
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end

  def of_age?
    return true if @age >= 18

    false
  end
  private :of_age?

  def can_use_services?
    return true if of_age? || @parent_permission

    false
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end
end
