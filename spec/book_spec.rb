require('rspec')
require('pg')
require('book')
require('spec_helper')
require('pry')


describe(Book) do
  describe(".all") do
    it("starts off with no book") do
      expect(Book.all()).to(eq([]))
    end
  end

  describe("#id") do
    it("tells you the name of the book and author") do
      book = Book.new({:id => 1, :id_author => 2, :id_title => 3})
      expect(book.id()).to(eq(1))
    end
  end

  describe("#id_author") do
    it("tells you the author of the book and author") do
      book = Book.new({:id => 1, :id_author => 2, :id_title => 3})
      expect(book.id_author()).to(eq(2))
    end
  end

  describe("#id_title") do
    it("sets its ID when you save it") do
      book = Book.new({:id => 1, :id_author => 2, :id_title => 3})
      book.save()
      expect(book.id_title()).to(eq(3))
    end
  end

  describe("#save") do
    it("lets you save books to the database") do
      book = Book.new({:id => 1, :id_author => 2, :id_title => 3})
      book.save()
      expect(Book.all()).to(eq([book]))
    end
  end

  describe("#==") do
    it("is the same book if it has the same name") do
      book1 = Book.new({:id => 1, :id_author => 2, :id_title => 3})
      book2 = Book.new({:id => 1, :id_author => 2, :id_title => 3})
      expect(book1).to(eq(book2))
    end
  end

  describe(".find") do
    it("returns a book by its ID") do
      test_book = Book.new({:id => 1, :id_author => 2, :id_title => 3})
      test_book.save()
      test_book2 = Book.new({:id => 2, :id_author => 2, :id_title => 3})
      test_book2.save()
      expect(Book.find(test_book2.id())).to(eq(test_book2))
    end
  end

  describe("#books") do
    it("returns an array of tasks for that book") do
      test_author = Author.new({:id => 1, :name => 'Dan'})
      test_author.save()
      test_title = Title.new({:id => 1, :title => 'Chiken Little'})
      test_title.save()
      test_book = Book.new({:id => 1, :id_author => test_author.id, :id_title => test_title.id})
      test_book.save()
      expect(Book.all).to eq([test_book])
    end
  end
end
