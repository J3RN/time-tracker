module TimeEntriesHelper
  def stop_btn(path)
    link_to "\ue074", path, class: "btn-stop"
  end

  def start_btn(path)
    link_to "\ue072", path, class: "btn-start"
  end
end
