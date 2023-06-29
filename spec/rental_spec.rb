require_relative '../rental'
require_relative '../student'
require_relative '../book'

describe Rental do
  context 'Check Teacher creating tasks' do
    it 'should create a Teacher' do
      person = Student.new(15, nil, true, 'Kyei')
      book = Book.new('Game of Thrones', 'George Martins')
      rental = Rental.new('2023/06/28', book, person)
      expect(rental.person.name).to eql('Kyei')
      expect(rental.book.author).to eql('George Martins')
      expect(person.rentals[0].book.title).to eql('Game of Thrones')
    end
  end
end
