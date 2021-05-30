class MostReadBooks::Scraper
  
  def general_info
    url = "https://www.goodreads.com/book/most_read"
    page = Nokogiri::HTML(open(url))
    page.css("tr").each do |b|
      title = b.css("[itemprop='name']")[0].text
      author = b.css("[itemprop='name']")[1].text
      url = "https://www.goodreads.com/#{b.css(".bookTitle")[0]['href']}"
      ratings = b.css(".minirating").text.strip
      readers = b.css(".greyText.statistic").text.strip.split("\n")[0]
      MostReadBooks::Book.new(title, author, url, ratings, readers)
    end
  end
  
  # def details
  #   MostReadBooks::Book.all.each do |b|
  #     # change this url to b.url
  #     page = Nokogiri::HTML(open(b.url).read)
  #     detail = page.css("#description span")[1].text
  #     format_num_of_pages = page.css("#details .row")[0].text
  #     publisher = page.css("#details .row")[1].text
  #     about_author = page.css(".bookAuthorProfile span")[0].text
  #   end
  # end
end