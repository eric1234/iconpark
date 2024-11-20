module Iconpark::Helpers
  def icon name, theme: Iconpark.default_theme, **html_options
    html_options[:class] = Array html_options[:class]
    html_options[:class] << 'ip' << theme
    content_tag 'svg', **html_options do
      tag 'use', href: asset_path("#{name}.svg##{name}")
    end
  end
end
