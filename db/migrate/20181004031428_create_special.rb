

class CreateSpecial < ActiveRecord::Migration[5.2]

  def change
    create_table :specials do |table|
      table.text    :name
      table.integer :runtime
      table.text    :image
    end
  end

end
