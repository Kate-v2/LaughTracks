

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

        @special1 = Special.create(name: "something",       runtime:10, image: "path1")
        @special2 = Special.create(name: "something else",  runtime:20, image: "path2")
        @special3 = Special.create(name: "some thing",      runtime:30, image: "path3")
        @special4 = Special.create(name: "some thing else", runtime:40, image: "path4")

        @comic1.specials << @special1
        @comic1.specials << @special2

        @comic3.specials << @special3
        @comic3.specials << @special4
      end

      describe 'Assess Query Parameters' do

        it 'should return all comedians when not queried' do
          no_query = {}
          list = Comedian.assess_params(no_query)
          expect(list).to eq(Comedian.all)
          expect(list.count).to eq(4)
          expect(list.include?(@comic1)).to eq(true)
          expect(list.include?(@comic2)).to eq(true)
          expect(list.include?(@comic3)).to eq(true)
          expect(list.include?(@comic4)).to eq(true)
        end

        it 'should return a subset of comedians when queried' do
          query = {age: 34}
          list = Comedian.assess_params(query)
          expect(list.count).to eq(2)
          expect(list.include?(@comic1)).to eq(true)
          expect(list.include?(@comic2)).to eq(true)
          expect(list.include?(@comic3)).to eq(false)
          expect(list.include?(@comic4)).to eq(false)
        end
      end

      it 'should average the age of comedians' do
        all_comedians = Comedian.assess_params({})
        average = all_comedians.average_age
        expect(average).to eq(27)

        some_comedians = Comedian.assess_params({age: 34})
        average = some_comedians.average_age
        expect(average).to eq(34)
      end

      it 'should aggregate a list unique cities from comedians' do
        all_comedians = Comedian.assess_params({})
        cities        = all_comedians.cities
        expect(cities.class).to eq(Array)
        expect(cities.count).to eq(2)
        expect(cities.include?(@city1)).to eq(true)
        expect(cities.include?(@city2)).to eq(true)

        some_comedians = Comedian.assess_params({age: 20})
        cities        = some_comedians.cities
        expect(cities.class).to eq(Array)
        expect(cities.count).to eq(1)
        expect(cities.include?(@city1)).to eq(false)
        expect(cities.include?(@city2)).to eq(true)
      end


      describe 'should interact with specials through Comedian' do

        it 'should return all specials when not filtered' do
          no_params = {}
          specials = Comedian.find_specials(no_params)
          expect(specials.count).to eq(4)
          included1 = specials.include?(@special1)
          included2 = specials.include?(@special2)
          included3 = specials.include?(@special3)
          included4 = specials.include?(@special4)
          expect(included1).to eq(true)
          expect(included2).to eq(true)
          expect(included3).to eq(true)
          expect(included4).to eq(true)
        end

        it 'should return only the relevant specials when filtered' do
          age_filtered = {age: @comic3.age}
          specials = Comedian.find_specials(age_filtered)
          expect(specials.count).to eq(2)
          included1 = specials.include?(@special1)
          included2 = specials.include?(@special2)
          included3 = specials.include?(@special3)
          included4 = specials.include?(@special4)
          expect(included1).to eq(false)
          expect(included2).to eq(false)
          expect(included3).to eq(true)
          expect(included4).to eq(true)
        end
      end


      describe 'Filter' do

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
