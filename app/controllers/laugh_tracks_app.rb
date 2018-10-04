
# These all need tests when we learn how to do that

class LaughTracksApp < Sinatra::Base

  def assess_params(params)
    return Comedian.all if params.empty? == true
    return Comedian.filter_by_age(params[:age]) if params[:age]
  end

  get '/comedians' do
    comedians = assess_params(params)
    erb :"comedians/index", locals: { comedians: comedians }
  end


end
