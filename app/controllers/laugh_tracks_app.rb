
class LaughTracksApp < Sinatra::Base

  get '/' do
    comedian = Comedian.assess_params(params)
    redirect "comedians/#{comedian.id}" if params[:name]
    erb :welcome
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
    # redirect "comedians/#{comedian.id}"
    redirect "comedians"
  end

  # This is broken
  # get "comedians/:id" do
  #   comedians = Comedian.find(params[:id])
  #   specials  = comedian.find_specials
  #   # erb :"comedians/comedian",
  #   erb :"comedians/index",
  #       locals: { comedian: comedians,
  #                 specials: specials  }
  # end

end
