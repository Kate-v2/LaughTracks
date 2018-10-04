

class Special < ActiveRecord::Base

  validates_presence_of :name, :run_time, :image

  belongs_to :comedian

end
