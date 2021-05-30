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
  end
  
  def display_book(book)
    puts "#{"-" * 14}#{book.title}#{"-" * 14}"
    puts "Author: #{book.author}"
    puts "Ratings: #{book.ratings}"
    sleep(1)
    puts ""
    puts "--Summary"
    book.summary.each do |p|
      puts  format_paragraph(p)
      puts ""
      sleep(1)
    end
    puts ""
    puts "--About The Author"
    puts format_paragraph(book.about_author)
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
  
  def format_paragraph(p)
    p.scan(/(.{1,75})(?:\s|$)/m)
  end

end