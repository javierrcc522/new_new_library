class Book
  attr_reader(:id,:id_author,:id_title)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @id_author = attributes.fetch(:id_author)
    @id_title = attributes.fetch(:id_title)
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
    result = DB.exec("INSERT INTO books (id, id_author, id_title) VALUES ('#{@id}', '#{@id_author}', '#{@id_title}') RETURNING id;")
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

end
