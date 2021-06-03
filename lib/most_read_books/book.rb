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
    self.all[0..input - 1].each.with_index(1) do |book, index|
      puts "#{index}. #{book.title} by #{book.author}"
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

  
  # def summary
  #   @summary = doc.css("#description span")[1].text
  # end
  
  def about_author
    if !doc.css(".bookAuthorProfile span").empty?
      if doc.css(".bookAuthorProfile span").length == 2
        about_author = doc.css(".bookAuthorProfile span")[1]
      else
        about_author = doc.css(".bookAuthorProfile span")[0]
      end
    else
      about_author = "No author info"
    end
    @about_author = about_author
    binding.pry
  end
    

    # if this has 2 elements choose [1]
    # if no span then no profile
    # puts doc.css(".bookAuthorProfile").text
    # binding.pry
    # element = doc.css(".bookAuthorProfile span")[1]
    # if !element.nil?
    #   @about_author = text_array(element)
    # else
    #   @about_author = ["There is no info about this author."]
    # end
  # end
  
  def summary
    # paragraphs = doc.css("#description span")[1].children.map do |p|
    #   p.text
    # end

    # squeeze = paragraphs.chunk_while do |p|
    #   p != "" && p != " "
    # end.to_a
   
    # summary = squeeze.map do |p|
    #   p.join
    # end
    
    # @summary = summary.select do |p|
    #   p != "" && p != " "
    # end
    
    text_array = doc.css("#description span")[1].children.map do |node|
      node.text
    end
    
    # text_groups is array of form [[true/false, [strings]],...]
    # true/false, strings grouped together based on return value of block
    text_groups = text_array.chunk do |line|
      line != "" && line != " "
    end.to_a
    
    @summary = text_groups.map do |group|
      group[1].join if group[0]
    end.compact
  end
  
  def maker
    text_array = doc.css("#description span")[1].children.map do |node|
      node.text
    end
    
    # text_groups is array of form [[true/false, [strings]],...]
    # true/false, strings grouped together based on return value of block
    text_groups = text_array.chunk do |line|
      line != "" && line != " "
    end.to_a
    
    @summary = text_groups.map do |group|
      group[1].join if group[0]
    end.compact
  end
  
  def format_summary
    self.summary.each do |p|
      puts p.scan(/(.{1,75})(?:\s|$)/m)
      puts ""
    end
  end
  
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
end