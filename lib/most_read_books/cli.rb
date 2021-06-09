class MostReadBooks::CLI

  def start
    MostReadBooks::Scraper.new.scrape_books
    puts ""
    puts "#{"-" * 30}Most Read Books#{"-" * 30}"
    puts "Welcome to Most Read Books. This application showcases the #{MostReadBooks::Book.all.length} most read"
    puts "books in the United States this week (according to Goodreads)." 
    puts ""
    list_books
  end

  def list_books
    print "How many books would you like to see? Enter a number from 1-#{MostReadBooks::Book.all.length}: "
    @input = gets.strip.to_i
    puts ""
    if (1..MostReadBooks::Book.all.length).include?(@input)
      puts "---Top #{@input} Most Read Books This Week"
      MostReadBooks::Book.print_books(@input)
      puts ""
      get_book
    else
      puts "Please enter a number from 1-#{MostReadBooks::Book.all.length}."
      puts ""
      list_books
    end
  end
  
  def get_book
    print "Select a book number for details (1-#{@input}): "
    book_number = gets.strip.to_i
    if (1..@input).include?(book_number)
      book = MostReadBooks::Book.find(book_number)
      puts ""
      display_book(book)
    else
      puts "Please enter a number from 1 - #{@input}."
      get_book
    end
  end
  
  def display_book(book)
    puts "---Number #{MostReadBooks::Book.all.index(book) + 1} Most Read Book This Week"
    puts "Title: #{book.title}"
    puts "Author: #{book.author}"
    puts "Publisher: #{book.publisher}"
    puts "Format: #{book.format}"
    puts "Page Count: #{book.page_count}"
    puts ""
    puts "#{book.title} has been read by #{book.readers} people this week."
    puts ""
    puts "---Summary"
    puts book.summary
    puts ""
    puts "---About Author"
    puts book.about_author
    puts ""
    see_more_books_or_exit
  end
  
  def see_more_books_or_exit
    print "Would you like to see more books? Enter 'y' or 'n': "
    input = gets.strip
    if input == "y"
      puts ""
      list_books
    elsif input == "n"
      close_application
    else
      puts "Please enter 'y' or 'n'."
      puts ""
      see_more_books_or_exit
    end
  end
  
  def close_application
    puts ""
    puts "Thank you for using Most Read Books. Have a nice day."
    exit
  end
end