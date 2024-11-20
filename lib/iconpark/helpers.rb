module Iconpark::Helpers
  using Iconpark::DeepMerge

  def icon name, theme: Iconpark.default_theme, **html_options
    html_options.force_array! :class
    Iconpark.default_html_options.force_array! :class

    html_options.deep_merge! Iconpark.default_html_options

    html_options[:class] << theme
    content_tag 'svg', **html_options do
      tag 'use', href: asset_path("#{name}.svg##{name}")
    end
  end
end
