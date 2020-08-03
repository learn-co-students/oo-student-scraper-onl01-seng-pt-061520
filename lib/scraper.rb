require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index = Nokogiri::HTML(html)
    page = index.css("div.student-card")
    page.collect do |student|
      {:name => student.css(".student-name").text ,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr('href').value
      }
    end
  end


  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    container = page.css("div.main-wrapper.profile .social-icon-container a")
    container.each do |element| 
      if element.attr('href').include?("twitter")
        student_profile[:twitter] = element.attr('href')
      elsif element.attr('href').include?("linkedin")
        student_profile[:linkedin] = element.attr('href')
      elsif element.attr('href').include?("github")
        student_profile[:github] = element.attr('href')
      elsif element.attr('href').end_with?("com/")
        student_profile[:blog] = element.attr('href')
      end
    end
    student_profile[:profile_quote] = page.css(".vitals-container .vitals-text-container .profile-quote").text
    student_profile[:bio] = page.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

    student_profile
  end
end

