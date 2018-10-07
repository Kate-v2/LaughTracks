RSpec.describe 'Viewing Comedians' do

  before(:each) do
    @city1 = "NYC"; @city2 = "JC"
    @comic1 = Comedian.create(name: 'One',   age: 34, hometown:@city1)
    @comic2 = Comedian.create(name: 'Two',   age: 34, hometown:@city2)
    @comic3 = Comedian.create(name: 'Three', age: 20, hometown:@city2)
    @comic4 = Comedian.create(name: 'Four',  age: 20, hometown:@city2)

    @special1 = Special.create(name: "something",       runtime:10, image: "https://testcreative.co.uk/wp-content/uploads/2017/10/Test-Logo-Circle-black-transparent.png")
    @special2 = Special.create(name: "something else",  runtime:20, image: "https://d1e4pidl3fu268.cloudfront.net/66963e4a-ccba-4fdd-ba18-d5862fb4dba7/test.png")
    @special3 = Special.create(name: "some thing",      runtime:30, image: "http://www.orseu-concours.com/76-292-thickbox/test-epso-de-raisonnement-numerique-4-fr.jpg")
    @special4 = Special.create(name: "some thing else", runtime:40, image: "https://d3icht40s6fxmd.cloudfront.net/sites/default/files/test-product-test.png")

    @comic1.specials << @special1
    @comic1.specials << @special2

    @comic3.specials << @special3
    @comic3.specials << @special4
  end

  describe 'Display list of comedians' do
    it 'should display all comics on the page' do
      count = Comedian.all.count
      visit '/comedians'
      list = all('.comedian')
      expect(list.count).to eq(count)
    end
    it 'should display only filtered comics on the page' do
      count = 2
      visit '/comedians?age=34'
      list = all('.comedian')
      expect(list.count).to eq(count)
    end
  end

  describe 'Statistics' do

    describe 'Count Total Specials of comics on the page' do
      it 'when all comics are present' do
        visit '/comedians'
        average = ((10 + 20 + 30 + 40) / 4).round(2)
        expect(page).to have_content("Average TV Special Run Time: #{average}")
      end
      it 'when some comics are preset' do
        visit '/comedians?age=34'
        average = ((10 + 20) / 2).round(2)
        expect(page).to have_content("Average TV Special Run Time: #{average}")
      end
    end

    describe 'Count Total Specials of comics on the page' do
      it 'when all comics are present' do
        visit '/comedians'
        expect(page).to have_content("Total TV Specials: 4")
      end
      it 'when some comics are preset' do
        visit '/comedians?age=34'
        expect(page).to have_content("Total TV Specials: 2")
      end
    end

    describe 'Average the age of all comics on the page' do
      it 'when all comics are present' do
        visit '/comedians'
        average = ((34 + 34 + 20 + 20) / 4).round
        expect(page).to have_content("Average Age: #{average}")
      end
      it 'when some comics are preset' do
        visit '/comedians?age=34'
        average = 34
        expect(page).to have_content("Average Age: #{average}")
      end
    end

    describe 'Display unique cities of comics on the page' do
      it 'when all comics are present' do
        visit '/comedians'
        expect(page).to have_content("Cities: #{@city2} #{@city1}")
      end
      it 'when some comics are present' do
        visit '/comedians?age=20'
        expect(page).to_not have_content("Cities: #{@city2} #{@city1}")
        expect(page).to have_content("Cities: #{@city2}")
        expect(page).to_not have_content("#{@city1}")
      end
    end
  end


end
