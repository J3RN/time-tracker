module ApplicationHelper
  def std_date(date)
    date.strftime("%A, %B #{date.day.ordinalize}")
  end
end
