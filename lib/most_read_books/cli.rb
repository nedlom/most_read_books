class MostReadBooks::CLI
  
  def start
    puts "Welcome to Most Read Books"
    MostReadBooks::Scraper.new.general_info
    list_books
  end
  
  def list_books
    MostReadBooks::Book.all.each.with_index(1) do |b, i|
      puts "#{i}. #{b.title} by #{b.author}"
      puts ""
    end
    
    print "Select number of book: "
    book_index = gets.strip.to_i
    book = MostReadBooks::Book.find_by_index(book_index)
    puts ""
    display_book(book)
    #self.class.tester(book)
  end
  
  #########
  
  def self.t
    MostReadBooks::Scraper.new.general_info
    self.pick
  end
  
  def self.tester(book)
    book.info
    puts book.summary
    self.pick
  end
  
  def self.pick
    puts "select a book"
    book_index = gets.strip.to_i
    book = MostReadBooks::Book.find_by_index(book_index)
    self.tester(book)
  end 
  ################
  
  def display_book(book)
    book.info
    puts "#{"-" * 14}#{book.title}#{"-" * 14}"
    puts "Author: #{book.author}"
    puts "Ratings: #{book.ratings}"
    sleep(1)
    puts ""
    puts "--Summary"
    book.summary.each do |p|
      puts  p.scan(/(.{1,75})(?:\s|$)/m)
      puts ""
      sleep(1)
    end
    puts ""
    puts "--About The Author"
    puts book.about_author.scan(/(.{1,75})(?:\s|$)/m)
    puts ""
    puts "This book has been read by #{book.readers.strip.split("\n")[0]} people this week."
    puts ""
    select_another
  end
  
  def select_another
    print "Select number of book: "
    book_index = gets.strip.to_i
    book = MostReadBooks::Book.find_by_index(book_index)
    puts ""
    display_book(book)
  end
    
  
end