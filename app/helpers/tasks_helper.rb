module TasksHelper
  def days_left(days)
    days || "???"
  end

  def complete_btn(path)
    link_to "\ue117", path, class: "btn-complete"
  end

  def uncomplete_btn(path)
    link_to "\ue118", path, class: "btn-uncomplete"
  end
end
