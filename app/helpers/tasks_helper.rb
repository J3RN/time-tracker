module TasksHelper
  def days_left(days)
    days || "???"
  end

  def archive_btn(path)
    link_to "\ue118", path, class: "btn-archive"
  end

  def unarchive_btn(path)
    link_to "\ue117", path, class: "btn-unarchive"
  end
end
