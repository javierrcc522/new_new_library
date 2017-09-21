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
    result = DB.exec("INSERT INTO titles (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def delete
    DB.exec("DELETE FROM titles WHERE id = #{@id};")
  end

  def ==(another_title)
    (self.id==another_title.id).&(self.title==another_title.title)
  end

  def update(title)
    @new_title = title
    DB.exec("UPDATE titles SET title = '#{@new_title}' WHERE id = #{@id}")
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

end
