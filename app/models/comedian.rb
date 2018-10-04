

class Comedian < ActiveRecord::Base

  validates_presence_of :name, :age #, :hometown

  has_many :specials

  def self.assess_params(params)
    return all if params.empty? == true
    return filter_by_age(params[:age]) if params[:age]
  end

  def self.average_age

    average(:age)
  end

  def self.cities
    pluck(:hometown).uniq
  end

  def self.filter_by_age(age)
    all.select { |comic| comic.age == age.to_i }
  end



end
