require 'open-uri'
require 'pry'

class Scraper

  @students = {}

  def self.scrape_index_page(index_url)
    uri = Nokogiri::HTML(open(index_url))
    uri.css(".student-card").map do |student|
      # name => student.css(".student-name").text
      @students = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").text
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    uri = Nokogiri::HTML(open(profile_url))
    student_info = {
        :bio => uri.css(".description-holder p").text,
        :profile_quote => uri.css(".profile-quote").text
      }
    socials = uri.css(".social-icon").map {|icon| icon.attr("src")}
    if i = socials.find_index("../assets/img/twitter-icon.png")
      student_info[:twitter] = uri.css(".social-icon-container a")[i].attr("href")
    end
    if i = socials.find_index("../assets/img/linkedin-icon.png")
      student_info[:linkedin] = uri.css(".social-icon-container a")[i].attr("href")
    end
    if i = socials.find_index("../assets/img/github-icon.png")
      student_info[:github] = uri.css(".social-icon-container a")[i].attr("href")
    end
    if i = socials.find_index("../assets/img/rss-icon.png")
      student_info[:blog] = uri.css(".social-icon-container a")[i].attr("href")
    end
    
   student_info
 



    
  end

end

