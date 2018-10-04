
require_relative '../app/models/comedian.rb'
require_relative '../app/models/special.rb'


comedian1 = {name: "Jerry Seinfeld", age: 64, hometown:"Massapequa - New York"}
c1_img1 = "https://m.media-amazon.com/images/M/MV5BOTc2N2I0Y2UtOTgyYy00MTU3LTk1YzItZGIwMDcxY2JkMGQzXkEyXkFqcGdeQXVyMjQzNzk2ODk@._V1_UY268_CR1,0,182,268_AL_.jpg"
c1_spec1 = {name: "Jerry Before Seinfeld", runtime:62, image:c1_img1 }

c1_img2 = "https://m.media-amazon.com/images/M/MV5BNDM4OTY0NTAyMF5BMl5BanBnXkFtZTcwNTcxMDQyMQ@@._V1_UY268_CR0,0,182,268_AL_.jpg"
c1_spec2 = {name: "Jerry Seinfeld: 'I'm Telling You for the Last Time'", runtime:75, image:c1_img2 }

# Jerry Seinfeld: Stand-Up Confidential,55,https://m.media-amazon.com/images/M/MV5BYjZlNTgxMzYtZjc1ZS00OTQzLThiYWYtMTEzYjNmNDM1NmFkXkEyXkFqcGdeQXVyMzU0NzkwMDg@._V1_UX182_CR0,0,182,268_AL_.jpg


com1 = Comedian.create(comedian1)
# com1.specials += Special.create(c1_spec1)
# com1.specials += Special.create(c1_spec2)
c1_sp1 = Special.create(c1_spec1)
c1_sp2 = Special.create(c1_spec2)
com1.specials = [c1_sp1, c1_sp2]
