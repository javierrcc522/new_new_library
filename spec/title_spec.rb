require("spec_helper")

describe(Title) do
  describe(".all") do
    it("starts off with no titles") do
      expect(Title.all()).to(eq([]))
    end
  end

  describe("#title") do
    it("tells you its title") do
      title = Title.new({:id => 1, :title => "Dan"})
      expect(title.title()).to(eq("Dan"))
    end
  end

  describe("#save") do
    it("lets you save titles to the database") do
      title = Title.new({:id => 1, :title => "Dan"})
      title.save()
      expect(Title.all()).to(eq([title]))
    end
  end

  describe("#==") do
    it("is the same title if it has the same title") do
      title1 = Title.new({:id => 1, :title => "Dan"})
      title2 = Title.new({:id => 1, :title => "Dan"})
      expect(title1).to(eq(title2))
    end
  end

  describe(".find") do
    it("returns a title by its ID") do
      title1 = Title.new({:id => 1, :title => "Dan"})
      title1.save()
      title2 = Title.new({:id => 2, :title => "Javi"})
      title2.save()
      expect(Title.find(title2.id())).to(eq(title2))
    end
  end

  describe("#update") do
    it("updates a title") do
      title = Title.new({:id => 1, :title => "Dan"})
      title.save()
      title.update({:title => "Dan"})
      expect(title.title()).to(eq("Dan"))
    end
  end

  describe("#delete") do
    it("lets you delete an title from the database") do
      title1 = Title.new({ :id => 1, :title => "Dan"})
      title1.save()
      title2 = Title.new({:id => 2, :title => "Javi"})
      title2.save()
      title1.delete()
      expect(Title.all()).to(eq([title2]))
    end
  end
  # describe("#tasks") do
  #   it("returns an array of tasks for that title") do
  #     test_title = Title.new({:id => 1, :title => "Title Dan", :id_specialties => 1})
  #     test_title.save()
  #     test_task = Task.new({:description => "Learn SQL", :title_id_specialties => test_title.id_specialties(), :deadline => "2017-09-05 00:00:00"})
  #     test_task.save()
  #     test_task2 = Task.new({:description => "Review Ruby", :title_id_specialties => test_title.id_specialties(), :deadline => "2017-09-05 00:00:00"})
  #     test_task2.save()
  #     expect(test_title).to(eq([test_task, test_task2]))
  #   end
  # end
end
