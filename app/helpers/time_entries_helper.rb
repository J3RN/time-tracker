module TimeEntriesHelper
  def duration_display(minutes)
    if minutes >= 60
      hours = minutes / 60
      minutes = minutes - (hours * 60)

      "#{hours}h#{minutes}m"
    else
      "#{minutes}m"
    end
  end

  def long_duration_display(minutes)
    if minutes >= 60
      hours = minutes / 60
      minutes = minutes - (hours * 60)

      "#{hours} hours, #{minutes} minutes"
    else
      "#{minutes} minutes"
    end
  end

  def stop_btn(path)
    link_to "\ue074", path, class: "btn-stop"
  end
end
