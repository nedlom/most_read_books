require "pry"
require "open-uri"
require "nokogiri"

module MostReadBooks
  class Error < StandardError; end
  require "require_all"
  require_rel "most_read_books"
end
