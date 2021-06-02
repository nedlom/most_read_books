class MostReadBooks::CLI
  
  def welcome
    puts <<~WELCOME
    
      #{format_headers("Most Read Books", "-")}
      Welcome to Most Read Books. This application provides details on the 50 most 
      read books in the United States this week (according to Goodreads). 
    
    WELCOME
    MostReadBooks::Scraper.new.scrape_books
    select_books
  end
  
  def select_books
    print "How many books would you like to see(1-50)? "
    input = gets.strip.to_i
    if (1..50).include?(input)
      puts ""
      list_books(input - 1)
    else
      puts ""
      puts "Please choose a number from 1-50."
      puts ""
      select_books
    end
  end
  
  def list_books(input)
    # puts "#{"-"*22}Top #{input + 1} Most Read Books This Week#{"-"*22}"
    # puts ""
    puts "---Most Read Books This Week"
    MostReadBooks::Book.all[0..input].each.with_index(1) do |b, i|
      puts "#{i}. #{b.title} by #{b.author}"
    end
    puts ""
    select_book
  end
  
  def select_book
    print "Enter a number for more info: "
    book_index = gets.strip.to_i
    book = MostReadBooks::Book.find_by_index(book_index)
    puts ""
    display_book(book)
  end
  
  def display_book(book)
    puts <<~PICK 
      #{format_headers(book.title, "-")}
      #{format_headers("by #{book.author}", " ")}
      You have chosen #{book.title} by #{book.author}. It is the number #{MostReadBooks::Book.all.find_index(book)} 
      most read book of the week. The #{book.page_count} page #{book.format} published by #{book.publisher} 
      has been been read by #{book.readers} people this week.
      
    PICK
    puts "---Summary"
    format_paragraphs(book.summary)
    puts "---About Author"
    format_paragraphs(book.about_author)
    select_another
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
 
   def format_paragraphs(paragraph_array)
    paragraph_array.each do |p|
      puts p.scan(/(.{1,75})(?:\s|$)/m)
      puts ""
    end
  end
  
  def format_headers(header, symbol)
    wide = (75 - header.length) / 2
    print "#{symbol * wide}#{header}#{symbol * wide}"
  end
  
  def exit_application
    puts ""
    puts "Have a nice day."
    exit
  end
  
  # def format_paragraph(p)
  #   p.scan(/(.{1,75})(?:\s|$)/m)
  # end
end