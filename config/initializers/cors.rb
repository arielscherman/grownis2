Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins %w[
      https://grownis.com
      http://grownis.com
      https://www.grownis.com
      http://www.grownis.com
      https://grownis.herokuapp.com
      http://grownis.herokuapp.com
    ]
    resource '/assets/*'
  end
end
