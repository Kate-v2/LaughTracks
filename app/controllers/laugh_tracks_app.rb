
class LaughTracksApp < Sinatra::Base

  get '/' do
    if params[:name]
      name = params[:name]
      # comedian = Comedian.find_by(name: name)
      comedian = Comedian.find_by_name(name)
      redirect "comedians/#{comedian.id}"
    else
      erb :welcome
    end
  end

  get '/comedians' do
    comedians = Comedian.assess_params(params)
    specials  = comedians.find_specials
    erb :"comedians/index",
        locals: { comedians: comedians,
                  specials:  specials   }
  end

  get '/comedians/new' do
    erb :"comedians/new"
  end

  post '/comedians' do
    comedian = Comedian.create(params[:comedian])
    redirect "comedians/#{comedian.id}"
  end

  get 'comedians/:id' do
    comedian = Comedian.find(params[:id])
    specials.comedian.find_specials
    erb :"comedians/comedian",
        locals: { comedian: comedian,
                  specials: specials  }
  end



end
