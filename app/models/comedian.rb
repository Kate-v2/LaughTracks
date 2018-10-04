

class Comedian < ActiveRecord::Base

  validates_presence_of :name, :age #, :hometown

  has_many :specials

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
