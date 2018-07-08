module ApplicationHelper
  def std_date(date)
    date.strftime("%A, %B #{date.day.ordinalize}")
  end

  def edit_btn(path)
    link_to "\ue065", path, class: "btn-edit"
  end

  def delete_btn(path)
    link_to "\ue020", path, method: :delete, data: { confirm: "Are you sure?" }, class: "btn-delete"
  end

  def duration_display(minutes)
    hours = minutes / 60
    minutes = minutes % 60
    "#{format('%02d', hours)}:#{format('%02d', minutes)}"
  end

  def long_duration_display(minutes)
    hours = minutes / 60
    minutes = minutes % 60

    hour_string = "hour".pluralize(hours)
    minute_string = "minute".pluralize(minutes)

    "#{hours} #{hour_string} and #{minutes} #{minute_string}"
  end

  def task_with_tag_labels(task)
    task_div = content_tag(:div, task.task_name)
    tag_spans = task.tags.map do |tag|
      content_tag(:span, tag.name, class: ["label", "label-info"])
    end
    task_div + tag_spans.join.html_safe
  end

  def span_task_with_tag_labels(task)
    task_div = content_tag(:span, task.task_name, class: "task-title")
    tag_spans = task.tags.map do |tag|
      content_tag(:span, tag.name, class: ["label", "label-info"])
    end
    task_div + tag_spans.join.html_safe
  end
end
