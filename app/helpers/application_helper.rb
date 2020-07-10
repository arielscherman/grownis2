module ApplicationHelper
  def async_loader(id, url)
    content_tag(:div, nil, class: id, data: { controller: "async-card", "async-card-url": url, "async-card-placeholder-id": id }) do
      concat spinner
    end
  end

  def spinner
    content_tag(:div, nil, class: "ui-loading") do
      concat content_tag(:i, nil, class: "ui-spinner")
      concat content_tag(:p, "Cargando", class: "ui-spin")
    end
  end

  def current_page?(controller:, action:)
    if action.present?
      Array(controller).include?(controller_name) && action_name == action
    else
      Array(controller).include?(controller_name)
    end
  end

  def active_class_for(controller:, action: nil)
    "active" if current_page?(controller: controller.to_s, action: action.to_s)
  end
end
