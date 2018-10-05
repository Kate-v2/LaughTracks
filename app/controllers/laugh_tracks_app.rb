
# These all need tests when we learn how to do that

class LaughTracksApp < Sinatra::Base

  get '/comedians' do
    comedians = Comedian.assess_params(params)
    specials = comedians.find_specials
    erb :"comedians/index",
        locals: { comedians: comedians,
                  specials: specials }
  end


end
