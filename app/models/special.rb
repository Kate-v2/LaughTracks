


class Special < ActiveRecord::Base

  validates_presence_of :name #, :runtime #, :image

  belongs_to :comedian

end
