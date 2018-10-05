

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
  end

  def self.cities(params = {})
    comics = assess_params(params)
    total_specials(params)
    comics.distinct.pluck(:hometown)
  end

  def self.total_specials(params = {})
    comics = assess_params(params)
    # comics.pluck(:specials).count
    # comics.specials.count
    # comics.pluck(:specials, :each).count
    # comics.pluck(:each, :specials).count
    # comics.pluck(:specials, each: true).count
    # binding.pry
    # comics.count(has_many: :specials )
    # Comedian.specials
    find_specials(params)
  end

# :nested_attributes_options,
# :nested_attributes_options=
# :reflect_on_all_aggregations
# :reflect_on_all_associations,

  def self.find_specials(params = {})
    comics = assess_params(params)
    comic_ids = comics.select(:id)
    specials = Special.where(comedian_id: comic_ids )
    binding.pry
  end


  # --- Filter ----

  def self.filter_by_age(age)
    where({age: age})
  end




end
