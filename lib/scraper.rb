require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    student_array = []

      index.css("div.student-card").each do |studentcard|
        
      studenthash = {
        :name => studentcard.css("h4").text,
        :location => studentcard.css("p").text,
        :profile_url => studentcard.css("a").attribute("href").value
      }
      student_array << studenthash
    
      end
      student_array
    # student_name = index.css("div.student-card").css("h4").text
    # student_location = index.css("div.student-card").css("p").text
    # student_url = index.css("div.student-card").css("a").attribute("href").value
    #hash = {"key1" => "value1"}
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}

    # twitter : profile.css("div.social-icon-container").css("a")[0].attribute("href").value
    #profilequote : profile.css("div.profile-quote").text
    #bio : profile.css("div.description-holder").css("p").text
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

