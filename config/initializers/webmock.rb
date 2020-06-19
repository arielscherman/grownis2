if Rails.env.test?
  require 'webmock'
  WebMock.disable_net_connect!(allow_localhost: true, allow: "github.com") # github is for firefox driver
end
