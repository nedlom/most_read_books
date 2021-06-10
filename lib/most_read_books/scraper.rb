class MostReadBooks::Scraper

  def scrape_books
    page = Nokogiri::HTML(open("https://www.goodreads.com/book/most_read").read)
    page.css("tr").each do |b|
      title = b.css("[itemprop='name']").first.text
      author = b.css("[itemprop='name']").last.text
      url = "https://www.goodreads.com/#{b.css(".bookTitle").first['href']}"
      ratings = b.css(".minirating").text.strip
      readers = b.css(".greyText.statistic").text.strip.split("\n").first
      MostReadBooks::Book.new(title, author, url, ratings, readers)
    end
  end
  
end