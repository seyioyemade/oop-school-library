require "./person.rb"

class Teacher < Person
  def initialize(specialization)
    super(42, 'Stephen')
    @specialization = specialization
  end

  def can_use_services?
    return true
  end
end
