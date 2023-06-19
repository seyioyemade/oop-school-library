class Person
  def initialize(age, name = "Unknown", parent_permission = true)
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def id
    @id
  end

  attr_accessor :name
  attr_accessor :age

  def of_age?
    if @age >= 18
      return true
    else
      return false
    end
  end
  private :of_age?

  def can_use_services?
    if of_age? || @parent_permission
      return true
    else
      return false
    end
  end

end
