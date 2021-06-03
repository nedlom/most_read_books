class MostReadBooks::Book
  
  attr_accessor :title, :author, :url, :ratings, :readers, :summary, :format, :page_count, :publisher, :about_author
  
  @@all = []
  
  def self.all
    @@all
  end
  
  def self.find(id)
    self.all[id - 1]
  end
  
  def self.print_books(input=nil)
    if input.nil?
      self.all.each.with_index(1) do |book, index|
        puts "#{index}. #{book.title} by #{book.author}"
      end  
    else
      self.all[0..input - 1].each.with_index(1) do |book, index|
        puts "#{index}. #{book.title} by #{book.author}"
      end 
    end
  end  

  def initialize(title=nil, author=nil, url=nil, ratings=nil, readers=nil)
    @title = title
    @author = author
    @url = url
    @ratings = ratings
    @readers = readers
    self.class.all << self
  end
  
  # def add_info
  #   self.page_count = book_page.css("#details .row")[0].text.split(" ")[1]
  #   self.format = book_page.css("#details .row")[0].text.split(",")[0]
  #   self.publisher = book_page.css("#details .row")[1].text.strip.split("by ").last
  #   self.summary = text_array(book_page.css("#description span")[1])
    
  #   element = book_page.css(".bookAuthorProfile span")[1]
  #   if !element.nil?
  #     self.about_author = text_array(element)
  #   else
  #     @about_author = ["There is no info about this author."]
  #   end
  # end
  
  def doc
    Nokogiri::HTML(open(self.url).read)
  end
  
  #text_array 
  def text_array(element)
    node_set = element.children
      paragraphs = node_set.map do |n|
        if n.name == "br"
          n.name
        else
          n.text
        end
      end
      paragraphs.delete(" ")
      paragraphs = paragraphs.join.split("brbr")
      paragraphs.delete_if {|p| p == "" || p == " " || p == "br"}
      paragraphs
  end
  
  def summary
    element = doc.css("#description span")[1]
    binding.pry
    @summary = text_array(book_page.css("#description span")[1])
  end
  
  def about_author
    element = doc.css(".bookAuthorProfile span")[1]
    if !element.nil?
      @about_author = text_array(element)
    else
      @about_author = ["There is no info about this author."]
    end
  end
  
  def format
    @format = doc.css("#details .row")[0].text.split(",")[0]
  end
  
  def page_count
    @page_count = doc.css("#details .row")[0].text.split(" ")[1]
  end
  
  def publisher
    @publisher = doc.css("#details .row")[1].text.strip.split("by ").last
  end
end