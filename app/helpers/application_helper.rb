module ApplicationHelper
  def async_loader(id, url)
    content_tag(:div, nil, data: { controller: "async-card", "async-card-url": url, "async-card-placeholder-id": id }) do
      concat spinner
    end
  end

  def spinner
    content_tag(:div, nil, class: "ui-loading") do
      concat content_tag(:i, nil, class: "ui-spinner")
      concat content_tag(:p, "Cargando", class: "ui-spin")
    end
  end
end
