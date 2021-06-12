class MostReadBooks::Book
  
  attr_accessor :title, :author, :url, :avg_rating, :total_ratings, :readers, :doc, :format, :page_count, :publisher, :summary, :about_author
  
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

  # avg_rating=nil, total_ratings=nil,
  def initialize(title=nil, author=nil, url=nil,  readers=nil)
    @title = title
    @author = author
    @url = url
    # @avg_rating = avg_rating
    # @total_ratings = total_ratings
    @readers = readers
    self.class.all << self
  end
  
  # don't use set ratings on initialize
  # only need title, author, url, and readers
  # @doc.css("[itemprop='ratingValue']").text.strip
  
  def doc
    @doc ||= Nokogiri::HTML(open(url).read)
    
  end
  
  def avg_rating
    @avg_rating ||= @doc.css("[itemprop='ratingValue']").text.strip
  end
  
  def total_ratings
    binding.pry
    @total_ratings ||= @doc.css("[href='#other_reviews']").text.strip.split("\n").first
  end
  
  def format
    @format ||= doc.css("[itemprop='bookFormat']").text
  end
  
  def page_count
    @page_count ||= doc.css("[itemprop='numberOfPages']").text.split(" ").first
  end
  
  def publisher
    @publisher ||= doc.css("#details .row").text.split(/by |\n\n/)[1]
  end
  
  def summary
    @summary ||= format_text(doc.css("#description span").last)
  end
  
  def about_author
    @about_author ||= if doc.css(".bookAuthorProfile span").empty?
      @about_author = "There is no information for this author."
    else
      if doc.css(".bookAuthorProfile span").length == 2
        @about_author = format_text(doc.css(".bookAuthorProfile span").last)
      else
        @about_author = format_text(doc.css(".bookAuthorProfile span").first) 
      end
    end
  end

  def format_text(noko_element)
    text_array = noko_element.children.map do |node|
      if node.children.empty? 
        node.text
      else
        node.children.map do |a|
          a.text
        end
      end
    end.flatten
    
    text_groups = text_array.chunk do |line|
      line != "" && line != " " && line != "\u00A0"
    end.to_a
    
    paragraphs = text_groups.map do |group|
      group[1].join if group[0]
    end.compact
    
    # removes a reference to an image seen on webpage.
    paragraphs.delete_at(0) if paragraphs[0].downcase.include?("edition")

    paragraph_lines = paragraphs.map do |paragraph|
      paragraph.scan(/(.{1,75})(?:\s|$)/m)
    end

    paragraph_lines.map do |line|
      line.join("\n") 
    end.join("\n\n")
  end
  
end