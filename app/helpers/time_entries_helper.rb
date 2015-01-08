module TimeEntriesHelper
  def hours_duration(rational)
    rational.round(2).to_s + " hours"
  end
end
