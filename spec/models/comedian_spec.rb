
RSpec.describe Comedian do

  describe 'Validations' do

    describe 'Required Field(s)' do

      it 'should be invalid if missing a name' do
        comic = Comedian.create(age: 48)
        expect(comic).to_not be_valid
      end

      it 'should be invalid if missing an age' do
        comic = Comedian.create(name: 'Mitch Hedberg')
        expect(comic).to_not be_valid
      end

    end
  end

  describe 'Class Methods' do

    describe 'Statistics' do

      it 'should average the age of all comedians' do
        comic1 = Comedian.create(name: 'One', age: 1)
        comic2 = Comedian.create(name: 'Two', age: 3)

        average = Comedian.average_age
        expect(average).to eq(2)
      end

      it 'should aggregate a list of all uniq cities' do
        city1 = "NYC"; city2 = "JC"
        comic1 = Comedian.create(name: 'One', age: 1, hometown:city1)
        comic2 = Comedian.create(name: 'Two', age: 3, hometown:city2)
        comic3 = Comedian.create(name: 'Three', age: 4, hometown:city2)

        list = Comedian.cities
        expected = [city1, city2]
        expect(list).to eq(expected)
      end

      describe 'Filtering' do

        it 'should return a collection filtered by a single age' do
          comic1 = Comedian.create(name: 'One', age: 34)
          comic2 = Comedian.create(name: 'Two', age: 34)
          comic3 = Comedian.create(name: 'Three', age: 20)
          comic4 = Comedian.create(name: 'Four', age: 23)

          age = "34"
          expected = [comic1, comic2]
          list = Comedian.filter_by_age(age)
          expect(list).to eq(expected)
        end


      end


    end
  end

end
