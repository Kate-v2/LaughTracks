
require_relative 'laugh_data'


comedians_path = 'db/data/comedians.csv'
comedians = LaughData.make_comedians(comedians_path)

specials_path = 'db/data/specials.csv'
specials = LaughData.make_specials(specials_path)
