

RSpec.describe Special do

  describe 'Validations' do

    describe 'Required Field(s)' do

      it 'should be invalid if missing a name' do
        special = Special.create
        expect(special).to_not be_valid
      end

    end
  end

  describe 'Class Methods' do

    describe 'Statistics' do

      it 'should average the length of all specials' do
        special_1 = Special.create(name: "One", runtime: 20)
        special_2 = Special.create(name: "Two", runtime: 40)

        average = Special.average_length
        expect(average).to eq(30)
      end

    end
  end

end
