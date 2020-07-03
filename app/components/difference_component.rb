class DifferenceComponent < ViewComponent::Base
  def initialize(amount)
    @amount = amount
  end

  def icon
    if @amount < 0
      helpers.content_tag(:i, nil, class: "icon-arrow-down #{css_color}")
    else
      helpers.content_tag(:i, nil, class: "icon-arrow-up #{css_color}")
    end
  end

  def css_color
    helpers.css_color_for(@amount)
  end
end
