require 'nokogiri'
require 'open-uri'
require 'pry'
require 'rubygems'

class Scraper
      
  SITE="https://learn-co-curriculum.github.io/student-scraper-test-page/"
  
  
  def self.scrape_index_page(index_url)

  index_page= Nokogiri::HTML(open(SITE))
     binding.pry
  end
    Scraper.new.scrape_index_page

  def self.scrape_profile_page(profile_url)
    
  end

end

