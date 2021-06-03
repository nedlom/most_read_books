class MostReadBooks::Book
  
  attr_accessor :title, :author, :url, :ratings, :readers, :book_format, :number_of_pages, :publisher, :summary, :about_author
  
  @@all = []
  
  def self.all
    @@all
  end
  
  def self.find(id)
    self.all[id - 1]
  end
  
  def self.print_books(input)
    self.all.take(input).each.with_index(1) do |book, index|
      puts "#{index}. #{book.title} by #{book.author}"
    end 
  end
  
  def initialize(student_hash)
    student_hash.each{|key, value| self.send(("#{key}="), value)}
    self.class.all << self
  end

  def initialize(title=nil, author=nil, url=nil, ratings=nil, readers=nil)
    @title = title
    @author = author
    @url = url
    @ratings = ratings
    @readers = readers
    self.class.all << self
  end
  
  def doc
    Nokogiri::HTML(open(self.url).read)
  end
  
  def book_format
    @format = doc.css("#details .row")[0].text.split(",")[0]
  end
  
  def number_of_pages
    @page_count = doc.css("#details .row")[0].text.split(" ")[1]
  end
  
  def publisher
    @publisher = doc.css("#details .row")[1].text.strip.split("by ").last
  end
  
  def about_author
    if doc.css(".bookAuthorProfile span").empty?
      @about_author = "There is no information for this author"
    else
      if doc.css(".bookAuthorProfile span").length == 2
        @about_author = make_paragraphs(doc.css(".bookAuthorProfile span")[1])
      else
        @about_author = make_paragraphs(doc.css(".bookAuthorProfile span")[0])
      end
    end
  end

  def summary
    @summary = make_paragraphs(doc.css("#description span")[1])
  end
  
  def make_paragraphs(element)
    text_array = element.children.map do |node|
      node.text
    end
    binding.pry
    
    # text_groups is array of form [[true or false, [strings]],...]
    # true or false/string arrayd determined by blocks return value
    text_groups = text_array.chunk do |line|
      line != "" && line != " "
    end.to_a
    
    text_groups.map do |group|
      group[1].join if group[0]
    end.compact
  end
  
  def format_paragraphs(x)
    if x.class == Array
      x.each do |p|
        puts p.scan(/(.{1,75})(?:\s|$)/m)
        puts ""
      end 
    else
      puts x
    end
  end
end