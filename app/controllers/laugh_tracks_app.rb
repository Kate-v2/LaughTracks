
# These all need tests when we learn how to do that

class LaughTracksApp < Sinatra::Base

  get '/comedians' do
    comedians = Comedian.all
    erb :"comedians/index", locals: { comedians: comedians }
    # Then I also see a list of each comedian's TV specials' names
  end




end
