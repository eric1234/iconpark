module Iconpark
  mattr_accessor :default_theme, default: 'outline'
end

require_relative "iconpark/version"
require_relative "iconpark/helpers"
require_relative "iconpark/engine"
