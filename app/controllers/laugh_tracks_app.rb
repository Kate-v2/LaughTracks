


class LaughTracksApp < Sinatra::Base

  get '/comedians' do
    comedians = Comedian.all
    erb :"comedians/index", locals: { comedians: comedians }
  end


end
