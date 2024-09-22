module Iconpark::Helpers
  def icon name, theme: Iconpark.default_theme
    content_tag 'svg', class: ['ip', theme] do
      tag 'use', href: asset_path("#{name}.svg##{name}")
    end
  end
end
