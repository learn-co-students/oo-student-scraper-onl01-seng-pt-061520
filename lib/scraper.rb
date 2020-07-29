require 'open-uri'
require 'pry'

class Scraper
      
  SITE="https://learn-co-curriculum.github.io/student-scraper-test-page/"
  
  def self.scrape_index_page(index_url)

    index_page= Nokogiri::HTML(open(SITE))
    #This block returns a list of student names
    student_names = []

    index_page.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_info = {:name => name,
                :location => location,
                :profile_url => profile_url}
      student_names << student_info
      end
    student_names
  end
  

  
  def self.scrape_profile_page(profile_url)
      
    doc= Nokogiri::HTML(open(profile_url))

       student_hash = {}

      social = doc.css(".social-icon-container a")
      social.each do |element| #iterate through each of the social elements and assign the keys if the item exists
        if element.attr('href').include?("twitter")
          student_hash[:twitter] = element.attr('href')
        elsif element.attr('href').include?("linkedin")
          student_hash[:linkedin] = element.attr('href')
        elsif element.attr('href').include?("github")
          student_hash[:github] = element.attr('href')
        elsif element.attr('href').end_with?("com/")
          student_hash[:blog] = element.attr('href')
        end
      end
      student_hash[:profile_quote] = doc.css(".profile-quote").text
      student_hash[:bio] = doc.css(".description-holder p").text

  student_hash

  end

end

#CSS Selector= .social-icon-container
#CSS Path=html body div.main-wrapper.profile div.vitals-container div.social-icon-container
#XPath=/html/body/div/div[2]/div[2]