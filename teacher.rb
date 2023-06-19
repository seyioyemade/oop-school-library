require './person'

class Teacher < Person
  def initialize(specialization)
    super(42, 'Stephen')
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
