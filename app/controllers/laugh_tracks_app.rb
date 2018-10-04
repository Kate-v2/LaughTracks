
# These all need tests when we learn how to do that

class LaughTracksApp < Sinatra::Base

  get '/comedians' do
    comedians = Comedian.assess_params(params)
    erb :"comedians/index", locals: { comedians: comedians }
  end


end
