require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
module ActiveSupport
  class TestCase
    fixtures :all
    include ApplicationHelper
  end
end
