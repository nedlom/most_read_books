class MostReadBooks::Book
  
  attr_accessor :title, :author, :url, :ratings, :readers, :doc, :format, :page_count, :publisher, :summary, :about_author
  
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

  def initialize(title=nil, author=nil, url=nil, ratings=nil, readers=nil)
    @title = title
    @author = author
    @url = url
    @ratings = ratings
    @readers = readers
    self.class.all << self
  end
  
  def doc
    @doc ||= Nokogiri::HTML(open(self.url).read)
  end
  
  def format
    @format ||= doc.css("#details .row")[0].text.split(/, | pages/).first
  end
  
  def page_count
    @page_count ||= doc.css("#details .row")[0].text.split(/, | pages/).last
  end
  
  def publisher
    @publisher ||= doc.css("#details .row")[1].text.split(/by |\n/)[4]
  end
  
  def summary
    @summary ||= format_text(doc.css("#description span")[1])
  end
  
  def about_author
    @about_author ||= if doc.css(".bookAuthorProfile span").empty?
      @about_author = "There is no information for this author"
    else
      if doc.css(".bookAuthorProfile span").length == 2
        @about_author = format_text(doc.css(".bookAuthorProfile span")[1])
      else
        @about_author = format_text(doc.css(".bookAuthorProfile span")[0])
      end
    end
  end

  # def testing(element)
  #   text_array = element.children.map do |node|
  #     node.text
  #   end
    
  #   array = []
    
  #   x = text_array.map.with_index do |a|
  #     if a != "" && a != " "
  #       array << a
  #     else
  #       array = []
  #       nil
  #     end
  #   end.compact
  #   binding.pry
    
    # element.children.chunk do |a|
    #   a.text != "" && a.text != " "
    # end.to_a.map do |b|
    #   b[1].map {|b| b.text}.join if b[0]
    # end.compact
    
    # element.children.chunk do |a|
    #   a.name != "br" && a.text != " "
    # end.to_a.map do |b|
    #   b[1].map{|c| c.text}.join if b[0
    # end.compact
    
    # text_array.group_by do |a|
    #     a != "" && a != " "
    # end
  # end

  def format_text(element)
    # used to be just node.text in block
    # added if statement to deal with non-text nodes
    # with children that had formatting
    # flatten add to 
    text_array = element.children.map do |node|
      if node.children.empty? 
        node.text
      else
        node.children.map do |a|
          a.text
        end
      end
    end.flatten
    # binding.pry
    
     #17 is an issue: 1, 8, 17, 21, 32, 50
    
    # text_groups returns array of form [[true or false, [strings]],...]
    # true or false/strings array determined by block's return value
    text_groups = text_array.chunk do |line|
      line != "" && line != " "
    end.to_a
    
    # binding.pry
    
    paragraphs = text_groups.map do |group|
      group[1].join if group[0]
    end.compact
    
    paragraphs.delete_at(0) if paragraphs[0].downcase.include?("edition")
    # binding.pry

    # previously returned value of paragraphs and passed to
    # format_paragraphs in CLI class.
    paragraph_lines = paragraphs.map do |x|
      x.scan(/(.{1,75})(?:\s|$)/m)
    end

    paragraph_lines.map do |t|
      t.join("\n")
    end.join("\n\n")
  end
  
  # def format_paragraphs(paragraphs)
  #   if paragraphs.class == Array
  #     paragraphs.each do |paragraph|
  #       puts paragraph.scan(/(.{1,75})(?:\s|$)/m)
  #       puts ""
  #     end 
  #   else
  #     puts paragraphs
  #   end
  # end
end