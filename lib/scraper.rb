require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    doc = Nokogiri::HTML(open(index_url))
    student_arr = doc.css(".student-card").each do |student|
      hash = {}
      hash[:location] = student.css(".student-location").text
      hash[:name] = student.css(".student-name").text
      hash[:profile_url] = student.css("a").attribute("href").value
      # binding.pry
      students_array << hash
    end
    students_array
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    # binding.pry
    hash = {}
    social_array = doc.css(".social-icon-container a").each do |url|
      social = url.attribute("href").value
      if social.include? "twitter"
        hash[:twitter] = social
      elsif social.include? "linkedin"
        hash[:linkedin] = social
      elsif social.include? "github"
        hash[:github] = social
      else
        hash[:blog] = social
      end
    end
    hash[:profile_quote] = doc.css(".profile-quote").text.strip
    hash[:bio] = doc.css(".description-holder p").text
    hash
  end

end
