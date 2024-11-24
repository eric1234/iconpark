require 'bundler/setup'

# Gems used to test
require "debug"
require 'nokogiri'

# Dep is on Rails as a whole but these are the only parts we use
require "action_view"
require "active_support/core_ext/module/attribute_accessors"
require "active_support/core_ext/kernel/concern"
require "rails/engine"

# Configure minitest to use spec syntax and autorun
require "minitest"
require "minitest/spec"
require "minitest/autorun"

# Load actual library we are testing
require_relative "../lib/iconpark"

alias context describe

# Custom expectations for testing
module Minitest::Expectations
  # Ensure the expected content matches the given selector
  def must_have_selector selector, message = nil
    doc = Nokogiri::HTML target
    message ||= "Expected to find selector '#{selector}' in '#{target}'"

    ctx.assert doc.at_css(selector), message
  end
end

class HelperTest < Minitest::Test
  def self.helper(&)
    define_method :helper do
      Class.new(&).tap do |helper|
        helper.include ActionView::Helpers::TagHelper
      end.new
    end
  end

  extend Minitest::Spec::DSL
  register_spec_type(self) { |_, *tags| tags.include? :helper }
end
