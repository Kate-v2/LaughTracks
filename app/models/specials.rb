


lass Special < ActiveRecord::Base

  validate_presence_of :name, # :runtime #, :image

  belongs_to :comedian

end
