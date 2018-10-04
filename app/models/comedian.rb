

class Comedian < ActiveRecord::Base

  validates_presence_of :name, :age #, :hometown

  has_many :specials

  def self.average_age
    average(:age)
  end

  def self.cities
    Comedian.pluck(:hometown).uniq
  end

end
