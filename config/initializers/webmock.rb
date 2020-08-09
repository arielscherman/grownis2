if Rails.env.test?
  require 'webmock'
  WebMock.disable_net_connect!(allow_localhost: true, allow: ["github.com", "github-production-release-asset-2e65be.s3.amazonaws.com"]) # github is for firefox driver
end
