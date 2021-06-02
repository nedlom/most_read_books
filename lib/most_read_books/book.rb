class MostReadBooks::Book
  
  attr_accessor :title, :author, :url, :ratings, :readers, :summary, :format, :page_count, :publisher, :about_author
  
  @@all = []
  
  def self.all
    @@all
  end
  
  def initialize(title, author, url, ratings, readers)
    @title = title
    @author = author
    @url = url
    @ratings = ratings
    @readers = readers
    self.class.all << self
  end
  
  def self.find_by_index(index)
    self.all[index - 1]
  end
  
  def summary
    element = doc.css("#description span")[1]
    @summary = text_array(element)
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
  
  def doc
    Nokogiri::HTML(open(self.url).read)
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