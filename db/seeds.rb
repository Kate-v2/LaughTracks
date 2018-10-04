
# How Should I be testing these -- where does my test folder go? -- I need to install Minitest -- need permission.


require 'CSV'

# require_relative './data/comedians.csv'

class LaughData

  def self.format_data(path)
    arr = CSV.parse(path)
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
    }
  end

end


comedians_path = './data/comedians.csv'
comedians_list = LaughData.format_data
