
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

0.times do

foo = 0
agent.page.search(".fld:nth-child(2)").each do |t|
puts t.text if foo <= 6
foo += 1
#puts foo
end
foo = 0
agent.page.links.find{ |l| l.text =~ /ster Treffer/}.click
end
#agent.page.search(".fld:nth-child(2)").each do |t|
#   puts t.text
# end


#puts page_test.forms

#agent.page.links_with(:href => /index=/)[0].click