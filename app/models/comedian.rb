



class Comedian < ActiveRecord::Base

  validates_presence_of :name, :age, :hometown

  has_many :specials

end
