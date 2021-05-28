class MostReadBooks::CLI
  
  def start
    puts "Welcome to Most Read Books"
    #scrape website for Books
    display_books
  end
  
  def display_books
    MostReadBooks::Book.all.each.with_index(1) do |b, i|
      puts "#{i}. #{b.title} by #{b.author}"
    end
    puts "select a book"
    book = gets.strip.to_i
    MostReadBooks::Book.find_by_index(book)
  end
  
  def book_summary
  end
  
end