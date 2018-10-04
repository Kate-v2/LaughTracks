require 'pry'

require 'CSV'

require 'sinatra/activerecord'

require_relative '../app/models/comedian.rb'
require_relative '../app/models/special.rb'

class LaughData

  # --- Parse CSV ---

  def self.format_data(path)
    arr = CSV.read(path)
    header, *rows = arr
    make_rows(header, rows)
  end

  def self.make_rows(header, rows)
    arr = rows.map { |row| make_row(header, row) }
  end

  def self.make_row(header, row)
    hash = {}
    # ct = row.count
    # return p "TOO MANY #{ct} #{row}" if row.count > 3
    row.each.with_index { |data, index|
      key = header[index].to_sym
      hash[key] = data
    }; return hash
  end


  # --- Seed Methods ---

  def self.assess_data(data)
    if data.class == Array && data.first.class == Hash
      return data
    elsif data.class == String && data.chars.last(3).join == "csv"
      hash = format_data(data)
    else
      "ERROR - unexpected DataType"
    end
  end

  def self.make_model(set, model)
    case model
    when :comedian
      Comedian.create(set)
    when :special
      Special.create(set)
    else
      "ERROR - unexpected Model"
    end
  end


      # __ make owners __

  def self.seed_models(data, model)
    data.map { |set| make_model(set, model) }
  end


      # __ make many __

  def self.make_many_via_link(data, many_model, link)
    new_hash = {}
    pairs = data.map { |set|
      key = set.delete(link)
      new_hash[key] = [] if new_hash[key] == nil
      new_hash[key] << make_model(set, many_model)
    }; return new_hash
  end

  def self.add_the_many_to_owners(data, owner_model, collection)
    if owner_model == :comedian
      data.map { |key, object|
        comic = Comedian.find_by(name:key)
        comic.send(collection) << object
       }
     else
       "ERROR - unexpected Owner"
     end
  end


    # --- Make Comedians ---

  def self.make_comedians(input)
    data = assess_data(input)
    return data if data.class == String
    seed_models(data, :comedian)
  end


  # --- Make Specials ---

  def self.make_specials(input)
    data = assess_data(input)
    return data if data.class == String   # return Error message
    groups = make_many_via_link(data, :special, :comedian) #column name to link data on as a hash key
    add_the_many_to_owners(groups, :comedian, :specials)
  end

end

# ------- TESTING -----------------------------------

# comedians_path = 'db/data/comedians.csv'
# comedians = LaughData.make_comedians(comedians_path)
#
# specials_path = 'db/data/specials.csv'
# specials = LaughData.make_specials(specials_path)

# comedian_data = LaughData.format_data(comedians_path)
# p comedian_data
# puts "  -------------------------   Comedians   -------------------------   "
# p comedians
# -- these work too --
# comedians = LaughData.make_comedians(comedian_data)
# p comedians
# comedians = LaughData.make_comedians(3)
# p comedians
# puts "  -------------------------   Specials   -------------------------   "
# p specials
