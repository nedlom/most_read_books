class MostReadBooks::Scraper
  
  def get_page
    url = "https://www.goodreads.com/book/most_read"
    Nokogiri::HTML(open(url))
    # nodeset of books: Nokogiri::HTML(open(url)).css("tr")
    # title: .css("[itemprop='name']").text
    #author: .css(".authorName").text
    #url: .css(".bookTitle")[0]['href']
    #people read: html.css(".statistic").text
    #reviews: .css(".minirating").text
  end
  
  def general_info
    get_page.css("tr").each do |b|
      title = b.css("[itemprop='name']").text
      author = b.css(".authorName").text
      url = "https://www.goodreads.com/#{b.css(".bookTitle")[0]['href']}"
      MostReadBooks::Book.new(title, author, url)
    end
  end
  
  def detailed_info
  end
  
  def scrape_page
    get_page.css("tr").each do |b|
      title = b.css("[itemprop='name']").text
      author = b.css(".authorName").text
      MostReadBooks::Book.new(title, author)
    end
  end
end
