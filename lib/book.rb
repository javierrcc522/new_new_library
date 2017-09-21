class Book
  attr_reader(:id,:id_author,:id_title)

  def initialize(attributes)
    @id = attributes[:id]
    @id_author = attributes[:id_author]
    @id_title = attributes[:id_title]
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      id = book.fetch("id").to_i
      id_author = book.fetch("id_author").to_i
      id_title = book.fetch("id_title").to_i
      books.push(Book.new({:id => id,:id_author => id_author, :id_title => id_title}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (id_author, id_title) VALUES (#{@id_author}, #{@id_title}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_book)
    (self.id==another_book.id).&(self.id_author==another_book.id_author).&(self.id_title==another_book.id_title)
  end

  def self.find(id)
    found_book = nil
    Book.all().each() do |book|
      if book.id().==(id)
        found_book = book
      end
    end
    found_book
  end

  def update(attributes)
    @id = attributes.fetch(:id, @id)
    DB.exec("UPDATE books SET id = '#{@id}' WHERE id = #{self.id()};")

    attributes.fetch(:id_author, []).each() do |id_author|
      DB.exec("INSERT INTO books (id_author, id_title) VALUES ('#{id_author}', '#{self.id()}');")
    end

    attributes.fetch(:id_title, []).each() do |id_title|
      DB.exec("INSERT INTO books (id_author, id_title) VALUES ('#{id_title}', '#{self.id()}');")
    end
  end

# def books
#   all_books = []
#   books = DB.exec("SELECT movie_id FROM actors_movies WHERE actor_id = #{self.id()};")
#   books.each() do |result|
#     movie_id = result.fetch("movie_id").to_i()
#     movie = DB.exec("SELECT * FROM movies WHERE id = #{movie_id};")
#     name = movie.first().fetch("name")
#     actor_movies.push(Movie.new({:name => name, :id => movie_id}))
#   end
#   all_books
# end


end
