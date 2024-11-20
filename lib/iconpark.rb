module Iconpark
  mattr_accessor :default_theme, default: 'outline'
  mattr_accessor :default_html_options, default: { class: 'ip' }
end

require_relative "iconpark/version"
require_relative "iconpark/deep_merge"
require_relative "iconpark/helpers"
require_relative "iconpark/engine"
