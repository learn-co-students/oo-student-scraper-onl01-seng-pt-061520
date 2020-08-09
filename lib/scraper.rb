require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    page.css("div.student-card").collect do |student|
      i = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.xpath('./a/@href').text
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    hash = {
      :profile_quote => page.css("div.profile-quote").text,
      :bio => page.css("p").text
    }
    page.css("div.social-icon-container a").each do |a|
      link = a.attr("href")
      if link.include?("twitter")
        hash[:twitter] = link
      elsif link.include?("linkedin")
        hash[:linkedin] = link
      elsif link.include?("github")
        hash[:github] = link
      else
        hash[:blog] = link
      end
    end
      hash
  end
end
