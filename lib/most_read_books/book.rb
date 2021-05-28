class MostReadBooks::Book
  
  attr_accessor :title, :author, :url, :summary
  
  @@all = []
  
  def self.all
    @@all
  end
  
  def initialize(title, author, url)
    @title = title
    @author = author
    @url = url
    self.class.all << self
  end
  
  def create_and_save
  end
  
  def self.add_data
    data = {'a' => 'b', 'c' => 'd'}
    data.each do |k,v|
      self.new(k, v)
    end
  end
  
  def self.find_by_title(title)
    self.all.detect do |b|
      b.title == title
    end
  end
  
  def self.find_by_author(author)
    self.all.select do |b|
      b.author == author
    end
  end
  
  def self.find_by_index(index)
    self.all[index - 1]
  end

end