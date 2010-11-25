
def do_ams

require "rubygems"
require "nokogiri"
require "open-uri"
require "mechanize"

agent = Mechanize.new { |agent|
    agent.user_agent_alias = 'Mac Safari'
  }

agent.get("http://jobroom.ams.or.at/jobsuche/FreieSuche.jsp")
form = agent.page.forms.first
form.query = "wien 1220"
form.submit
agent.page.links_with(:href => /index=/)[0].click

pagesmax = agent.page.search("span:nth-child(2)").first
puts pagesmax.text.to_i

10.times do

foo = 0
agent.page.search(".fld:nth-child(2)").each do |t|
puts t.text #unless t.text.to_s.blank?
foo += 1
#puts foo
end
foo = 0
agent.page.links.find{ |l| l.text =~ /ster Treffer/}.click
end
#agent.page.search(".fld:nth-child(2)").each do |t|
#   puts t.text
# end
end

#puts page_test.forms

#agent.page.links_with(:href => /index=/)[0].click

class Place
  #include Mongoid::Document
  #field :name
  #field :street

  #field :lat, :type => Float
  #field :lng, :type => Float

  def do_geocode!
    response = Net::HTTP.get_response(URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{Rack::Utils.escape(street)}&sensor=false"))
    json = ActiveSupport::JSON.decode(response.body)
    self.lat, self.lng = json["results"][0]["geometry"]["location"]["lat"], json["results"][0]["geometry"]["location"]["lng"]
  rescue
    false # For now, fail silently...
  end
end
