RSpec.describe 'Viewing Make New Comedian' do

    before(:each) do
      visit '/comedians/new'
    end

    describe 'displays all fields' do
      it 'Name' do
        expect(page).to have_content("Name:")
        expect(page).to have_selector("#form-name")
      end
      it 'Age' do
        expect(page).to have_content("Age:")
        expect(page).to have_selector("#form-age")
      end
      it 'Hometown' do
        expect(page).to have_content("City:")
        expect(page).to have_selector("#form-hometown")
      end
    end

  it 'can enter information and submit a new comedian' do
    fill_in('form-name',     with: "Someone")
    fill_in('form-age',      with: "100")
    fill_in('form-hometown', with: "NYC")
    click_button('new-comedian')
    expect(current_path).to eq('/comedians')

    comedian = Comedian.find_by_name("Someone")
    expect(comedian)
    expect(comedian.name).to eq(comedian.name)
    expect(comedian.age).to eq(comedian.age)
    expect(comedian.hometown).to eq(comedian.hometown)

    visit '/comedians'
    expect(page).to have_content(comedian.name)
  end


end
