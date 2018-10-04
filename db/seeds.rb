
# How Should I be testing these -- where does my test folder go? -- I need to install Minitest -- need permission.

require 'pry'

require 'CSV'

# require_relative './data/comedians.csv'

class LaughData

  def self.format_data(path)
    arr = CSV.read(path)
    head, *tail = arr
    create_hash(head, tail)
  end

  def self.create_hash(headers, rows)
    return "Incorrect pairing" if headers.count != rows.first.count
    array = rows.map { |row| make_row(row, headers) }
  end

  private

  def self.make_row(row, headers)
    hash = {}
    row.each.with_index { |data, index|
      hash[headers[index].to_sym] = data
    }; return hash
  end

end


comedians_path = '/Users/kt/turing/2mod/projects/LaughTracks/db/data/comedians.csv'
comedians_list = LaughData.format_data(comedians_path)
p comedians_list
