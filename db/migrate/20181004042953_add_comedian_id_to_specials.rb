class AddComedianIdToSpecials < ActiveRecord::Migration[5.2]

  def change
    add_column :specials, :comedian_id, :integer
  end

end
