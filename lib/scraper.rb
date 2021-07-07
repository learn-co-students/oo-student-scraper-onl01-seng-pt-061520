require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    student_array = []

      index.css("div.student-card").each do |student_card|
        
      student_hash = {
        :name => student_card.css("h4").text,
        :location => student_card.css("p").text,
        :profile_url => student_card.css("a").attribute("href").value
      }
      student_array << student_hash
    
      end
      student_array
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}
    
    profile.css("div.social-icon-container a").each do |site|
      if site.attribute("href").value.include?("twitter")
        student[:twitter] = site.attribute("href").value
      elsif
        site.attribute("href").value.include?("linkedin")
        student[:linkedin] = site.attribute("href").value
      elsif
        site.attribute("href").value.include?("github")
        student[:github] = site.attribute("href").value
      else
        student[:blog] = site.attribute("href").value
      end
    end
    student[:profile_quote] = profile.css("div.profile-quote").text
    student [:bio] = profile.css("div.description-holder").css("p").text
    student
  end

end

