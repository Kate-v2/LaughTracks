
# How Should I be testing these -- where does my test folder go? -- I need to install Minitest -- need permission.

require 'pry'

require 'CSV'
# require 'activerecord-import/base'
# require 'sinatra/activerecord'


require_relative '../app/models/comedian.rb'

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

  private   # wish this worked...

  def self.make_row(row, headers)
    hash = {}
    row.each.with_index { |data, index|
      hash[headers[index].to_sym] = data
    }; return hash
  end

end



comedians_path = '/Users/kt/turing/2mod/projects/LaughTracks/db/data/comedians.csv'
comedians_list = LaughData.format_data(comedians_path)
comedians = comedians_list.map { |hash| Comedian.create(hash) }

p comedian.all
