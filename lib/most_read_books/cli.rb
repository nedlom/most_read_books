class MostReadBooks::CLI
  
  def start
    puts "Welcome to Most Read Books"
    MostReadBooks::Scraper.new.general_info
    # display_books
  end
  
  def list_books
    MostReadBooks::Book.all.each.with_index(1) do |b, i|
      puts "#{i}. #{b.title} by #{b.author}"
      puts ""
    end
    
    puts "select a book"
    book_index = gets.strip.to_i
    book = MostReadBooks::Book.find_by_index(book_index)
    #display_book(book)
    self.class.tester(book)
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
    puts "----------#{book.title}----------"
    puts "by #{book.author}"
    puts book.ratings
    puts ""
    puts book.summary
    puts ""
    puts "---About The Author"
    puts book.about_author
    puts ""
    puts "This book has been read by #{book.readers.strip.split("\n")[0]} people this week."
  end
  
end