
RSpec.describe 'all comedians' do

  before(:each) do
    @comic1 = Comedian.create(name: 'One', age: 34)
    @comic2 = Comedian.create(name: 'Two', age: 34)
    @comic3 = Comedian.create(name: 'Three', age: 20)
    @comic4 = Comedian.create(name: 'Four', age: 23)

    @special_1 = Special.create(name: "Special 1", runtime: 100, comedian_id: 1)
    @special_2 = Special.create(name: "Special 2", runtime: 200, comedian_id: 1)
    @special_3 = Special.create(name: "Special 3", runtime: 300, comedian_id: 3)

    @comedians = Comedian.all
  end

  it 'should display all comics on the page' do
    count = Comedian.all.count
    visit '/comedians'
    list = all('.comedian')
    expect(list.count).to eq(count)
  end

end

RSpec.describe 'filtered comedians' do

  before(:each) do
    @comic1 = Comedian.create(name: 'One', age: 34)
    @comic2 = Comedian.create(name: 'Two', age: 34)
    @comic3 = Comedian.create(name: 'Three', age: 20)
    @comic4 = Comedian.create(name: 'Four', age: 23)

    @special_1 = Special.create(name: "Special 1", runtime: 100, comedian_id: 1)
    @special_2 = Special.create(name: "Special 2", runtime: 200, comedian_id: 1)
    @special_3 = Special.create(name: "Special 3", runtime: 300, comedian_id: 3)

    @comedians = Comedian.all
  end

  it 'should display all comics on the page' do
    count = 2
    visit '/comedians?age=34'
    list = all('.comedian')
    expect(list.count).to eq(count)
  end





end
