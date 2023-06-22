require './person'

class Student < Person
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.students << self
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  attr_reader :classroom

  def classroom = (classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end



john = Student.new(14, "ss2", 'john')
puts john.classroom
john.classroom = 'ss3'
puts john.classroom.label