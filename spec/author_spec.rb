require('rspec')
require('pg')
require('author')
require('spec_helper')


describe(Author) do
  describe(".all") do
    it("starts off with no authors") do
      expect(Author.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      author = Author.new({:id => 1, :name => "Author Dan"})
      expect(author.name()).to(eq("Author Dan"))
    end
  end

  describe("#save") do
    it("lets you save authors to the database") do
      author = Author.new({:id => 1, :name => "Author Dan"})
      author.save()
      expect(Author.all()).to(eq([author]))
    end
  end

  describe("#==") do
    it("is the same author if it has the same name") do
      author1 = Author.new({:id => 1, :name => "Author Dan"})
      author2 = Author.new({:id => 1, :name => "Author Dan"})
      expect(author1).to(eq(author2))
    end
  end

  describe(".find") do
    it("returns a author by its ID") do
      test_author = Author.new({:id => 1, :name => "Author Dan"})
      test_author.save()
      test_author2 = Author.new({:id => 2, :name => "Home stuff"})
      test_author2.save()
      expect(Author.find(test_author2.id())).to(eq(test_author2))
    end
  end

  # describe("#tasks") do
  #   it("returns an array of tasks for that author") do
  #     test_author = Author.new({:id => 1, :name => "Author Dan", :id_specialties => 1})
  #     test_author.save()
  #     test_task = Task.new({:description => "Learn SQL", :author_id_specialties => test_author.id_specialties(), :deadline => "2017-09-05 00:00:00"})
  #     test_task.save()
  #     test_task2 = Task.new({:description => "Review Ruby", :author_id_specialties => test_author.id_specialties(), :deadline => "2017-09-05 00:00:00"})
  #     test_task2.save()
  #     expect(test_author).to(eq([test_task, test_task2]))
  #   end
  # end
end
