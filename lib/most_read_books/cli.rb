class MostReadBooks::CLI
  def welcome
    MostReadBooks::Scraper.new.scrape_books
    puts ""
    puts "#{"-" * 30}Most Read Books#{"-" * 30}"
    puts "Welcome to Most Read Books. This application showcases the #{MostReadBooks::Book.all.length} most read"
    puts "books in the United States this week (according to Goodreads)." 
    puts ""
    menu
  end

  def menu
    print "How many books would you like to see? Enter a number from 1-#{MostReadBooks::Book.all.length}: "
    @input = gets.strip.to_i
    
    if (1..MostReadBooks::Book.all.length).include?(@input)
      puts ""
      puts "---Top #{@input} Most Read Books This Week"
      MostReadBooks::Book.print_books(@input)
      get_book
    else
      puts "Please enter a number from 1-#{MostReadBooks::Book.all.length}."
      puts ""
      menu
    end
    
    see_more_books_or_exit
  end
  
  def get_book
    puts ""
    print "Select a book number for details (1-#{@input}): "
    book_number = gets.strip.to_i
    if (1..@input).include?(book_number)
      book = MostReadBooks::Book.find(book_number)
      display_book(book)
    else
      puts "Please enter a number from 1 - #{@input}."
      get_book
    end
  end
  
  def display_book(book)
    puts ""
    puts "You've picked #{@input} most read book this week."
    puts "It's been read by #{book.readers} people this week."
    puts "Title: #{book.title}"
    puts "Author: #{book.author}"
    puts "Page Count: #{book.number_of_pages}"
    puts "Format: #{book.book_format}"
    puts "Publisher: #{book.publisher}"
    puts ""
    puts "---Summary"
    book.format_paragraphs(book.summary)
    puts ""
    puts "---About Author"
    book.format_paragraphs(book.about_author)
    puts ""
  end
  
  def see_more_books_or_exit
    print "Would you like to see more books? Enter 'y' or 'n': "
    input = gets.strip
    if input == "y"
      puts ""
      menu
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