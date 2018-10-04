

class Comedian < ActiveRecord::Base

  validates_presence_of :name, :age #, :hometown

  has_many :specials

  def self.assess_params(params)
    return all if params.empty? == true
    return filter_by_age(params[:age]) if params[:age]
  end

  def self.average_age(params)
    if params[:age]
      params[:age].to_i
    else
      average(:age)
    end
  end

  def self.cities(params)
    pluck(:hometown).uniq
  end

  def self.filter_by_age(age)
    all.select { |comic| comic.age == age.to_i }
  end



end
