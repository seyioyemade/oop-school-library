class Classroom
  attr_accessor :label, :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    @students.push(student)
    student.classroom = self
  end
end


ss2 = Classroom.new("ss2")
ss2.add_student('Seyi')

puts ss2.students.inspect