# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

author_1 = Author.create(name: "JRR Tolkien")
author_2 = Author.create(name: "JK Rowling")
author_3 = Author.create(name: "Michael Crichton")
author_4 = Author.create(name: "Stephen King")
author_5 = Author.create(name: "Peter Straub")
author_6 = Author.create(name: "John Grisham")
author_7 = Author.create(name: "John Krakauer")
author_8 = Author.create(name: "George RR Martin")

book_1 = Book.create(authors: [author_1], title: "Lord Of The Rings", pages: 400, year_published: 1954, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
book_2 = Book.create(authors: [author_1], title: "The Hobbit", pages: 497, year_published: 1937, image_url: "https://upload.wikimedia.org/wikipedia/en/thumb/3/30/Hobbit_cover.JPG/170px-Hobbit_cover.JPG")
book_3 = Book.create(authors: [author_2], title: "The Philosopher's Stone", pages: 350, year_published: 1998, image_url: "https://upload.wikimedia.org/wikipedia/en/6/6b/Harry_Potter_and_the_Philosopher%27s_Stone_Book_Cover.jpg")
book_4 = Book.create(authors: [author_2], title: "The Chamber of Secrets", pages: 300, year_published: 1999, image_url: "https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg")
book_5 = Book.create(authors: [author_3], title: "Jurassic Park", pages: 400, year_published: 1990, image_url: "https://upload.wikimedia.org/wikipedia/en/3/33/Jurassicpark.jpg")
book_6 = Book.create(authors: [author_4], title: "It", pages: 1138, year_published: 1986, image_url: "https://upload.wikimedia.org/wikipedia/en/5/5a/It_cover.jpg")
book_7 = Book.create(authors: [author_4], title: "The Shining", pages: 447, year_published: 1977, image_url: "https://upload.wikimedia.org/wikipedia/en/4/4c/Shiningnovel.jpg")
book_8 = Book.create(authors: [author_4, author_5], title: "The Talisman", pages: 921, year_published: 1984, image_url: "https://upload.wikimedia.org/wikipedia/en/8/89/Talisman1983Cover.jpg")
book_9 = Book.create(authors: [author_6], title: "The Pelican Brief", pages: 387, year_published: 1992, image_url: "https://upload.wikimedia.org/wikipedia/en/9/95/Pelican_brief_book_cover.jpg")
book_10 = Book.create(authors: [author_6], title: "The Firm", pages: 432, year_published: 1991, image_url: "https://upload.wikimedia.org/wikipedia/en/8/80/The_Firm_Grisham.jpg")
book_11 = Book.create(authors: [author_7], title: "Into Thin Air", pages: 416, year_published: 1997, image_url: "https://upload.wikimedia.org/wikipedia/en/4/46/Into_Thin_Air.jpg")
book_12 = Book.create(authors: [author_8], title: "A Game of Thrones", pages: 694, year_published: 1996, image_url: "https://upload.wikimedia.org/wikipedia/en/9/93/AGameOfThrones.jpg")

user_1 = User.create(name: "Book Luvr")
user_2 = User.create(name: "MoviesRKewler")
user_3 = User.create(name: "JurassicFan")
user_4 = User.create(name: "StephenKingIsMyHomie")
user_5 = User.create(name: "#isPeterOkay")
user_6 = User.create(name: "Leroy Jeeenkins")
user_7 = User.create(name: "Mother of Dragons")
user_8 = User.create(name: "Charizard54")


Review.create(title: "Awesome Book", rating: 5, text: "This book was awesome!!! Must Read!", user: user_1, book: book_1)
Review.create(title: "Great Book", rating: 5, text: "Mountain climbing sounds hard", user: user_1, book: book_11)
Review.create(title: "Awful Book", rating: 1, text: "WASTE OF TIME!", user: user_2, book: book_2)
Review.create(title: "DINOSAURS!", rating: 4, text: "Dinosaurs are pretty kewl.", user: user_3, book: book_5)
Review.create(title: "Dragons are cool.", rating: 5, text: "YAY Dragons!", user: user_7, book: book_12)
Review.create(title: "Charizard is cooler...", rating: 3, text: "Charizard would win in a fight with these dragons.", user: user_8, book: book_12)
Review.create(title: "This book is scary.", rating: 2, text: "Is Peter Okay?", user: user_5, book: book_7)
Review.create(title: "Everything floats down here.", rating: 5, text: "Chilling", user: user_4, book: book_6)
Review.create(title: "Red rum", rating: 5, text: "Here's Johnny!", user: user_4, book: book_7)
Review.create(title: "Let's do this!", rating: 1, text: "Not enough patience to finish the book.", user: user_6, book: book_10)
