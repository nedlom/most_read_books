class MostReadBooks::CLI
  def welcome
    puts ""
    puts "#{"-" * 30}Most Read Books#{"-" * 30}"
    puts "Welcome to Most Read Books. This application showcases the 50 most read"
    puts "books in the United States this week (according to Goodreads)." 
    puts ""
    MostReadBooks::Scraper.new.scrape_books
    menu
  end
  
  def menu
    print "Type list to see books or exit to quit program: "
    input = gets.strip
    if input == "list"
      list_books
      select_book
      display_book
    elsif input == "exit"
      exit
    else
      puts ""
      puts "Please enter list or exit."
      puts ""
      menu
    end
    menu
  end
  
  def list_books
    puts ""
      print "How many books would you like to see(1-50): "
      input = gets.strip.to_i
      if num_in_range?(input, 50)
        puts ""
        puts "---Top #{input} most read books of the week."
        MostReadBooks::Book.print_books(input)
      else
        puts ""
        puts "Please enter a number from 1 - 50"
        list_books
      end
  end
  
  def select_book
    puts "Enter number of book you want to see: "
    input = gets.strip.to_i
    
  end
  
  # puts ""
  #     print "Which book would you like to see? Enter a number 1-#{input}: "
  #     input = gets.strip.to_i
  #     book = MostReadBooks::Book.find(input)
  #     display_book(book)
  
  def num_in_range?(input, range)
    (1..range).include?(input)
  end
  
  
  def select_books
    print "How many books would you like to see(1-50)? "
    input = gets.strip.to_i
    if (1..50).include?(input)
      puts ""
      puts "---Top #{input} Most Read Books This Week"
      MostReadBooks::Book.print_books(input)
      puts ""
      select_book
    else
      puts ""
      puts "Please choose a number from 1-50."
      puts ""
      select_books
    end
  end

  def select_book
    print "Enter a number for more info: "
    book_index = gets.strip.to_i
    book = MostReadBooks::Book.find(book_index)
    puts ""
    display_book(book)
  end
  
  def display_book(book)
    puts ""
    puts "You've picked the number #{MostReadBooks::Book.all.find_index(book) + 1} most read book this week."
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
    menu
  end
  
  def select_another
    print "Would you like to see more books(y/n)? "
    input = gets.strip
    if input == "y"
      puts ""
      select_books
    elsif input == "n"
      exit_application
    else
      puts ""
      puts "Please enter y or n."
      puts ""
      select_another
    end
  end
  
  def exit_application
    puts ""
    puts "Have a nice day."
    exit
  end
end