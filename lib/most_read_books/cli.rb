class MostReadBooks::CLI
  
  def start
    puts "#{"-"*30}Most Read Books#{"-"*30}"
    # puts 'Welcome! Most Read Books is an application that'\
    #   ' provides details on the 50 most read books in the'\
    #   ' United States this week (according to Goodreads).'
      
    puts <<~WELCOME
      Welcome! Most Read Books is an application that provides details on the 50 
      most read books in the United States this week (according to Goodreads).
      
    WELCOME
    
    MostReadBooks::Scraper.new.general_info
    
    input = how_many
    puts ""
    list_books(input - 1)
  end
  
  def how_many
    puts "Would you like to see: "
    puts "1. Top 10"
    puts "2. Top 20"
    puts "3. Top 30"
    puts "4. Top 40"
    puts "5. See All"
    print "Enter a number(1-5): "
    gets.strip.to_i * 10
  end
  
  def list_books(input)
    puts "#{"-"*16}Top #{input + 1} Most Read Books This Week#{"-"*16}"
    sleep(1)
    puts ""
    MostReadBooks::Book.all[0..input].each.with_index(1) do |b, i|
      puts "#{i}. #{b.title} by #{b.author}"
      puts "#{" "*i.to_s.length}  Read by #{b.readers} people this week."
      puts ""
      sleep(0.5)
    end
    # print "Select number of book: "
    # book_index = gets.strip.to_i
    # book = MostReadBooks::Book.find_by_index(book_index)
    # puts ""
    # display_book(book)
  end
  
  def select_book
    print "Select number of book: "
    book_index = gets.strip.to_i
    book = MostReadBooks::Book.find_by_index(book_index)
    puts ""
    display_book(book)
  end
  
  def display_book(book)
    puts "---Summary"
    format_paragraphs(book.summary)
    puts "---About Author"
    format_paragraphs(book.about_author)
    select_book
  end
  
  # def display_book(book)
  #   puts "Title: #{book.title}"
  #   puts "Author: #{book.author}"
  #   puts "Ratings: #{book.ratings}"
  #   puts ""
  #   puts "---Summary"
  #   book.summary.each do |p|
  #     puts  format_paragraph(p)
  #     puts ""
  #   end
  #   puts "---About The Author"
  #   puts format_paragraph(book.about_author)
  #   puts ""
  #   puts "This book has been read by #{book.readers.strip.split("\n")[0]} people this week."
  #   puts ""
  #   select_another
  # end
  
  def format_paragraphs(paragraph_array)
    paragraph_array.each do |p|
      puts p.scan(/(.{1,75})(?:\s|$)/m)
      puts ""
    end
  end
  
  # def format_paragraph(p)
  #   p.scan(/(.{1,75})(?:\s|$)/m)
  # end

end