

class Comedian < ActiveRecord::Base

  validate_presence_of :name, :age #, :hometown

  has_many :specials

end
