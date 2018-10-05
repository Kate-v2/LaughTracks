

class Comedian < ActiveRecord::Base

  validates_presence_of :name, :age #, :hometown

  has_many :specials

  def self.assess_params(params = {})
    return all if params.empty? == true
    return filter_by_age(params[:age]) if params[:age]
  end

  def self.average_age(params = {})
    comics = assess_params(params)
    comics.average(:age)
    # if age = params[:age]
    #   filtered = filter_by_age(age)
    #   filtered.average(:age)
    #   # @age_filtered.average(:age)
    # else
    #   average(:age)
    # end
  end

  def self.cities(params = {})
    # pluck(:hometown).uniq
    distinct.pluck(:hometown)
  end


  # --- Filter ----

  def self.filter_by_age(age)
    # all.select { |comic| comic.age == age.to_i }
    # ^^^ This is ruby
    # select(:age == age)  ?
    # all.where(:age == age)
    @age_filtered = where({age: age})
  end



end
