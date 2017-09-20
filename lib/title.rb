class Title
  attr_reader(:id,:title)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
  end

  def self.all
    returned_titles = DB.exec("SELECT * FROM titles;")
    titles = []
    returned_titles.each() do |title|
      id = title.fetch("id").to_i
      title = title.fetch("title")
      titles.push(Title.new({:id => id, :title => title}))
    end
    titles
  end

  def save
    result = DB.exec("INSERT INTO titles (id, title) VALUES ('#{@id}', '#{@title}') RETURNING id;")
    # @id_specialties = result.first().fetch("id").to_i()
  end

  def ==(another_title)
    (self.id==another_title.id).&(self.title==another_title.title)
  end

  def self.find(id)
    found_title = nil
    Title.all().each() do |title|
      if title.id().==(id)
        found_title = title
      end
    end
    found_title
  end

  # def tasks
  #   title_tasks = []
  #   tasks = DB.exec("SELECT * FROM tasks WHERE title_id = #{self.id()};")
  #   tasks.each() do |task|
  #     description = task.fetch("description")
  #     title_id = task.fetch("title_id").to_i()
  #     title_tasks.push(Task.new({:description => description, :title_id => title_id}))
  #   end
  #   title_tasks
  # end
end
