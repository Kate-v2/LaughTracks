

RSpec.describe Comedian do

  describe 'Validations' do

    describe 'Required Field(s)' do
      it 'should be invalid if missing a name' do
        comic = Comedian.create(age: 48, hometown: 'Home Town')
        expect(comic).to_not be_valid
      end

      it 'should be invalid if missing an age' do
        comic = Comedian.create(name: 'Mitch Hedberg', hometown: 'Home Town')
        expect(comic).to_not be_valid
      end

      it 'should be invalid if missing a hometown' do
        comic = Comedian.create(name:'Mitch Hedberg', age:48 )
        expect(comic).to_not be_valid
      end


    end
  end
end
