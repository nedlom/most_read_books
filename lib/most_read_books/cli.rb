class MostReadBooks::CLI
  
  def welcome
    MostReadBooks::Scraper.new.general_info
    MostReadBooks::Book.all[0].format_and_pages
    puts <<~WELCOME
    
      #{"-"*30}Most Read Books#{"-"*30}
      Welcome to Most Read Books. This application provides details on the 50 most 
      read books in the United States this week (according to Goodreads). 
    
    WELCOME
    #MostReadBooks::Scraper.new.general_info
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
    puts "#{"-"*16}Top #{input + 1} Most Read Books This Week#{"-"*16}"
    puts ""
    MostReadBooks::Book.all[0..input].each.with_index(1) do |b, i|
      puts "#{i}. #{b.title} by #{b.author}"
    end
    puts ""
    select_book
  end
  
  def select_book
    print "Select book number for more detail: "
    book_index = gets.strip.to_i
    book = MostReadBooks::Book.find_by_index(book_index)
    puts ""
    display_book(book)
  end
  
  def display_book(book)
    len1 = (75 - book.title.length) / 2
    len2 = (75 - "by {book.author}".length) / 2
    place = MostReadBooks::Book.all.find_index(book) + 1
    puts "#{"-"*len1}#{book.title}#{"-"*len1}"
    puts "#{" "*len2}by #{book.author}#{" "*len2}"
    
    puts <<~PICK 
    
      Excellent selection! You've chosen the number #{place} most read book this week.
      It's been read by #{book.readers} people this week alone!
      
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
  
  def exit_application
    puts ""
    puts "Have a nice day."
    exit
  end
  
  # def format_paragraph(p)
  #   p.scan(/(.{1,75})(?:\s|$)/m)
  # end
end