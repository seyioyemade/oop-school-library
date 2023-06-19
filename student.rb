require './person'

class Student < Person
  def initialize(classroom)
    super(20, 'John')
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
