class MostReadBooks::CLI
  
  def start
    # puts "#{"-"*30}Most Read Books#{"-"*30}"
    # puts 'Welcome! Most Read Books is an application that'\
    #   ' provides details on the 50 most read books in the'\
    #   ' United States this week (according to Goodreads).'
      
    puts <<~WELCOME
    
      #{"-"*30}Most Read Books#{"-"*30}
      Hello. Welcome to Most Read Books. This is an application that provides 
      details on the 50 most read books in the United States this week (according 
      to Goodreads).
      
    WELCOME
    
    MostReadBooks::Scraper.new.general_info
    
    input = how_many
    puts ""
    list_books(input - 1)
  end
  
  def how_many
    print "Would you like to see some books? (JUST HIT ENTER): "
    input = gets.strip
    puts ""
    puts "Which ones: "
    puts "1. Top 10"
    puts "2. Top 20"
    puts "3. Top 30"
    puts "4. Top 40"
    puts "5. See All"
    print "Enter a number(1-5): "
    x = gets.strip.to_i
    if ![1,2,3,4,5].include?(x)
      puts ""
      how_many
    else
      x * 10
    end
  end
  
  def list_books(input)
    puts "#{"-"*16}Top #{input + 1} Most Read Books This Week#{"-"*16}"
    sleep(1)
    puts ""
    MostReadBooks::Book.all[0..input].each.with_index(1) do |b, i|
      puts "#{i}. #{b.title} by #{b.author}"
      # puts "#{" "*i.to_s.length}  Read by: #{b.readers}"
      puts ""
      sleep(0.5)
    end
    print "Select book number for more detail(1-#{input+1}): "
    select_book
    # print "Select number of book: "
    # book_index = gets.strip.to_i
    # book = MostReadBooks::Book.find_by_index(book_index)
    # puts ""
    # display_book(book)
  end
  
  def select_book
    # print "Select book number for more detail: "
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
    
    print "Hit enter key for summary: "
    gets
    puts ""
    puts "---Summary"
    format_paragraphs(book.summary)
    t_function
    self.class.face
    print "Hit enter key for author info: "
    gets
    puts ""
    puts "---About Author"
    format_paragraphs(book.about_author)
    t_function
    select_another
  end
  
  def select_another
    print "Would you like to see some books? Type q and hit enter to quit: "
    input = gets.strip
    if input == "q"
      quit
    else
      puts ""
      puts "Which ones: "
      puts "1. Top 10"
      puts "2. Top 20"
      puts "3. Top 30"
      puts "4. Top 40"
      puts "5. See All"
      print "Enter a number(1-5): "
      input = gets.strip.to_i * 10 - 1
      puts ""
      list_books(input)
    end
  end
  
  def t_function
    puts <<-T

    IF YOU'RE SEEING THIS IT MEANS YOU HIT THE ENTER KEY FOR MORE BOOK 
    INFORMATION. THE INFORMATION IS PRINTED TO THE SCREEN INSTANTANEOUSLY.
    YOU ARE AT THE BOTTOM OF THE OUTPUT. YOU NEED TO PUT THE MOUSE CURSOR 
    IN THE BLACK BOX (TERMINAL) AT THE BOTTOM OF THE SCREEN, CLICK INTO IT 
    THEN USE TWO FINGERS TO SCROLL DOWN ON THE MOUSE PAD TO SEE WHERE THE 
    INFORMATION YOU REQUESTED STARTS. 
    
    T
  end
  
  def quit
    puts ""
    puts "Buh Bye"
    sleep(1)
    puts ""
    exit
  end
  
  def self.face
    puts "\tO O\n\t < \n"
    15.times do
      print "\t - "
      sleep(0.5)
      print "\b\b0 - WARNING!"
      sleep(0.5)
      print "\b\b\b\b\b\b\b\b\b\b          \r"
    end
    print "\t o - You've been warned!"
    puts ""
    puts ""
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