require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html =  open(index_url)
    index_page = Nokogiri::HTML(html)

    index_page.css("div.student-card").map do |student|
      student_hash = Hash.new.tap do |h|
        h[:name] = student.css(".student-name").text
        h[:location] = student.css(".student-location").text
        h[:profile_url] = student.css("a").first["href"]
      end
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    
    student_bio_hash = Hash.new.tap do |student|
      
      profile_page.css(".social-icon-container a").each do |social|
        case 
        when social["href"].include?("twitter")
          student[:twitter] = social["href"]
        when social["href"].include?("linkedin")
          student[:linkedin] = social["href"]
        when social["href"].include?("github")
          student[:github] = social["href"] 
        else
          student[:blog] = social["href"] 
        end
      end
      
      student[:profile_quote] = profile_page.css(".profile-quote").text
      student[:bio] = profile_page.css(".description-holder p").text
    end
  end
end

