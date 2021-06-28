require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :firefox, screen_size: [1400, 1400]

  # Set English as the defualt_locale for all system tests
  setup do
    app.default_url_options[:locale] = :en
  end

end
