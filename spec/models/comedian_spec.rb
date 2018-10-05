
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

      before(:each) do
        @city1 = "NYC"; @city2 = "JC"
        @comic1 = Comedian.create(name: 'One',   age: 34, hometown:@city1)
        @comic2 = Comedian.create(name: 'Two',   age: 34, hometown:@city2)
        @comic3 = Comedian.create(name: 'Three', age: 20, hometown:@city2)
        @comic4 = Comedian.create(name: 'Four',  age: 20, hometown:@city2)
      end

      it 'should assess when there are no query params and return all comedians' do
        visit '/comedians'
        empty = {}
        expect(params).to eq(empty)
        comedians = Comedian.assess_params
        expect(comedians).to eq(Comedian.all)
      end

      it 'should assess when there are query params and return all comedians' do
        visit '/comedians?age=34'
        hash = {age: 34}
        expect(params).to eq(hash)
        comedians = Comedian.assess_params
        expect(list.class).to eq(Array)
        expect(list.count).to eq(2)
        expect(list.include?(@comic1)).to eq(true)
        expect(list.include?(@comic2)).to eq(true)
      end

      it 'should average the age of all comedians' do
        average = Comedian.average_age
        expect(average).to eq(27)
      end

      it 'should aggregate a list of all unique cities' do
        list = Comedian.cities
        expect(list.class).to eq(Array)
        expect(list.count).to eq(2)
        expect(list.include?(@city1)).to eq(true)
        expect(list.include?(@city2)).to eq(true)
      end

      describe 'should interact with specials through Comedian' do

        # it 'should '

      end



      describe 'Filtering' do

        it 'should return a collection filtered by a single age' do
          age = "34"
          expected = [@comic1, @comic2]
          list = Comedian.filter_by_age(age)
          expect(list).to eq(expected)
        end

      end


    end
  end

end
