class Author
  attr_reader(:id,:name)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  def self.all
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      id = author.fetch("id").to_i
      name = author.fetch("name")
      authors.push(Author.new({:id => id, :name => name}))
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (id, name) VALUES ('#{@id}', '#{@name}') RETURNING id;")
    # @id_specialties = result.first().fetch("id").to_i()
  end

  def ==(another_author)
    (self.id==another_author.id).&(self.name==another_author.name)
  end

  def self.find(id)
    found_author = nil
    Author.all().each() do |author|
      if author.id().==(id)
        found_author = author
      end
    end
    found_author
  end

  # def tasks
  #   author_tasks = []
  #   tasks = DB.exec("SELECT * FROM tasks WHERE author_id = #{self.id()};")
  #   tasks.each() do |task|
  #     description = task.fetch("description")
  #     author_id = task.fetch("author_id").to_i()
  #     author_tasks.push(Task.new({:description => description, :author_id => author_id}))
  #   end
  #   author_tasks
  # end
end
