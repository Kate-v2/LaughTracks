


class Special < ActiveRecord::Base

  validates_presence_of :name #, :runtime #, :image

  belongs_to :comedian

  def self.average_length
    average(:runtime) ? average(:runtime) : 0
  end

end
