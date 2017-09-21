require("spec_helper")

describe(Author) do
  describe(".all") do
    it("starts off with no authors") do
      expect(Author.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      author = Author.new({:id => 1, :name => "Dan"})
      expect(author.name()).to(eq("Dan"))
    end
  end

  describe("#save") do
    it("lets you save authors to the database") do
      author = Author.new({:id => 1, :name => "Dan"})
      author.save()
      expect(Author.all()).to(eq([author]))
    end
  end

  describe("#==") do
    it("is the same author if it has the same name") do
      author1 = Author.new({:id => 1, :name => "Dan"})
      author2 = Author.new({:id => 1, :name => "Dan"})
      expect(author1).to(eq(author2))
    end
  end

  describe(".find") do
    it("returns a author by its ID") do
      author1 = Author.new({:id => 1, :name => "Dan"})
      author1.save()
      author2 = Author.new({:id => 2, :name => "Javi"})
      author2.save()
      expect(Author.find(author2.id())).to(eq(author2))
    end
  end

  describe("#update") do
    it("updates a author") do
      author = Author.new({:id => 1, :name => "Dan"})
      author.save()
      author.update({:name => "Dan"})
      expect(author.name()).to(eq("Dan"))
    end
  end

  describe("#delete") do
    it("lets you delete an author from the database") do
      author1 = Author.new({ :id => 1, :name => "Dan"})
      author1.save()
      author2 = Author.new({:id => 2, :name => "Javi"})
      author2.save()
      author1.delete()
      expect(Author.all()).to(eq([author2]))
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
