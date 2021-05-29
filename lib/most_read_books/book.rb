class MostReadBooks::Book
  
  attr_accessor :title, :author, :url, :ratings, :readers, :summary, :pages, :publisher, :about_author
  
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
  
  def info
    @summary = doc.css("#description span")[1].text
    @pages = doc.css("#details .row")[0].text #gives book format and num of pages
    @publisher = doc.css("#details .row")[1].text
    @about_author = doc.css(".bookAuthorProfile span")[0].text
  end
 
  def doc
    Nokogiri::HTML(open(self.url).read)
  end
  
   # def details
  #   MostReadBooks::Book.all.each do |b|
  #     # change this url to b.url
  #     page = Nokogiri::HTML(open(b.url).read)
  #     detail = page.css("#description span")[1].text
  #     format_num_of_pages = page.css("#details .row")[0].text
  #     publisher = page.css("#details .row")[1].text
  #     about_author = page.css(".bookAuthorProfile span")[0].text
  #   end
  # end

end