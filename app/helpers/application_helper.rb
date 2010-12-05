module ApplicationHelper

  def nl2br(s)
    s.gsub(/\n/, "<br />")
  end

  def delaut(s)
    s.match(/(.*)(?=,\sAustria)/)
  end

end
