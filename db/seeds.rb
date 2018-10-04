



# comedian1 = {name: "Jerry Seinfeld", age: 64, hometown:"Massapequa - New York"}
# c1_img1 = "https://m.media-amazon.com/images/M/MV5BOTc2N2I0Y2UtOTgyYy00MTU3LTk1YzItZGIwMDcxY2JkMGQzXkEyXkFqcGdeQXVyMjQzNzk2ODk@._V1_UY268_CR1,0,182,268_AL_.jpg"
# c1_spec1 = {name: "Jerry Before Seinfeld", runtime:62, image:c1_img1 }
#
# c1_img2 = "https://m.media-amazon.com/images/M/MV5BNDM4OTY0NTAyMF5BMl5BanBnXkFtZTcwNTcxMDQyMQ@@._V1_UY268_CR0,0,182,268_AL_.jpg"
# c1_spec2 = {name: "Jerry Seinfeld: 'I'm Telling You for the Last Time'", runtime:75, image:c1_img2 }
#
# # Jerry Seinfeld: Stand-Up Confidential,55,https://m.media-amazon.com/images/M/MV5BYjZlNTgxMzYtZjc1ZS00OTQzLThiYWYtMTEzYjNmNDM1NmFkXkEyXkFqcGdeQXVyMzU0NzkwMDg@._V1_UX182_CR0,0,182,268_AL_.jpg
#
#
# com1 = Comedian.create(comedian1)
# # com1.specials += Special.create(c1_spec1)
# # com1.specials += Special.create(c1_spec2)
# c1_sp1 = Special.create(c1_spec1)
# c1_sp2 = Special.create(c1_spec2)
# com1.specials = [c1_sp1, c1_sp2]


require 'pry'

require 'CSV'

require 'sinatra/activerecord'

require_relative '../app/models/comedian.rb'
require_relative '../app/models/special.rb'


# HOW TO TEST THESE?
#  -- structure?
#  -- minitest ? need permission to install new gem
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


  # --- General Methods ---

  def self.assess_data(data)
    if data.class == Array && data.first.class == Hash
      return data
    elsif data.class == String && data.chars.last(3).join == "csv"
      hash = format_data(data)
    else
      "Input Error"
    end
  end

  def self.seed_models(data, model)
    data.map { |set| make_model(set, model) }
  end

  def self.make_model(set, model)
    case model
    when :comedian
      Comedian.create(set)
    when :special
      Special.create(set)
    # else
    #   "ERROR"
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
      make_many_via_link(data, :special, :comedian) #column name to link data on as a hash key
    end

    def self.make_many_via_link(data, many_model, link)
      data.map { |set| make_model_via_link(set, many_model, link) }
    end


    def self.make_model_via_link(data, model, link)
      key = data.delete(link).to_sym
      if model == :special
        new_hash = { key => make_model(data, model) }
      # else
      #   "Unknown Model as a belongs_to"
      end
    end

    def self.link_models_via_keys(data, owner, many, collection)
      pair_new_objects_with_key(data, many)
    end

    def self.pair_new_objects_with_key(data, model)
      if model == :special
        special = Special.create(data.values.first)
      end
    end


end

comedians_path = 'db/data/comedians.csv'
# comedian_data = LaughData.format_data(comedians_path)
# p comedian_data
comedians = LaughData.make_comedians(comedians_path)
puts "  -------------------------   Comedians   -------------------------   "
p comedians
# -- these work too --
# comedians = LaughData.make_comedians(comedian_data)
# p comedians
# comedians = LaughData.make_comedians(3)
# p comedians

specials_path = 'db/data/specials.csv'
specials = LaughData.make_specials(specials_path)
puts "  -------------------------   Specials   -------------------------   "
p specials
