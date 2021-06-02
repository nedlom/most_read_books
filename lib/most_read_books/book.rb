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
  
  # problem summary: 2, 3, 6, 8, 9, 10
  def summary1
    element = doc.css("#description span")[1]
    node_set = element.children
    paragraphs = node_set.map do |n|
      if n.name == "br"
        n.name
      else
        n.text
      end
    end
    paragraphs.delete(" ")
    paragraphs.join.split("brbr")
  end
  
  def summary2
    element = doc.css("#description span")[1]
    node_set = element.children
    paragraphs = node_set.map do |n|
      n.text
    end
    paragraphs.delete("")
    paragraphs
  end
  
  #could be nil or "\""
  # could be paragraphs
  def about_author
    element = doc.css(".bookAuthorProfile span")[1]
    if !element.nil?
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
      @about_author = paragraphs
    else
      @about_author = ["There is no info about this author."]
    end
  end
  
  def format
    binding.pry
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
  
  
    #binding.pry
      # elsif n.name == "i"
      #   " #{n.text} "
      # else
      #   "\n"
      # end
    # end
    # binding.pry
    #paragraphs = node_set.map{|p| p.text.strip}
    # binding.pry
    # paragraphs = paragraphs.select do |element|
    #   element.length > 1
    # end
    # index = paragraphs.find_index do |p|
    #   p[p.length - 1] == ","
    # end
    # paragraphs[index - 1] = "#{paragraphs[index - 1]} #{paragraphs[index]} " 
    # paragraphs[index] = ""
    # paragraphs.delete("")
    # paragraphs.delete_at(0) if !paragraphs[0].match?(/[a-zA-Z]/)
    # paragraphs.delete_at(0) if paragraphs[0].include?("Alternat")
    
    # index = paragraphs.find_index do |p|
    #   p[0] == ", "
    # end
    # binding.pry
  #   @summary = paragraphs
  # end
    # binding.pry
    # noko_element = doc.css("#description span")[1]
    # nodeset = noko_element.children
    # paragraph = nodeset.map do |element|
    #   element.text.strip
    # end
    # paragraph = paragraph.delete_if do |p|
    #   p == "" || p == " "
    # end
    #binding.pry
    # binding.pry
    #paragraphs = description_nodes.children.map.with_index do |p, i|
      #binding.pry
     # p.text.strip if p.name != "br"
      # if p.name == "i" && i > 0
      #   " " + p.text + " "
      # elsif p.name != "br"
      #   p.text
      # end
      # if p.name == "i" && i > 0
      #   " " + p.text + " "
      # end
    # end
    # paragraphs.delete(" ")
    # paragraphs.delete("")
    # @summary = paragraphs.compact
  # end
  

  
  
    #binding.pry
    # to print:
    # a.summary.each do |b|
# [9] pry(#<MostReadBooks::CLI>)*   puts  b.scan(/(.{1,75})(?:\s|$)/m)
# [9] pry(#<MostReadBooks::CLI>)*   puts ""
# [9] pry(#<MostReadBooks::CLI>)* end
  # def info
  #   @summary = doc.css("#description span")[1].text
  #   @pages = doc.css("#details .row")[0].text #gives book format and num of pages
  #   @publisher = doc.css("#details .row")[1].text
  #   @about_author = doc.css(".bookAuthorProfile span")[0].text
  # end
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