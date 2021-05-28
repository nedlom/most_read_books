class MostReadBooks::Scraper
  
  def scrape_page
    url = "https://learn.co/tracks/full-stack-web-development-v8/module-1-welcome/section-1-welcome/welcome-to-learn"
    html = Nokogiri::HTML(open(url))
    binding.pry
  end
  
  def make_book
  end
end