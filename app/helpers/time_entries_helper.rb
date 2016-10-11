module TimeEntriesHelper
  def stop_btn(path)
    link_to "\ue074", path, class: "btn-stop"
  end
end
