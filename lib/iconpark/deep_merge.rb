module Iconpark::DeepMerge
  refine Hash do
    def deep_merge other
      recursive = ->(_, a, b) { a.merge b, &recursive }
      merge other, &recursive
    end

    def deep_merge!(other) = replace deep_merge other
    def force_array!(key) = self[key] = Array(self[key])
  end

  refine Array do
    alias merge concat
  end

  refine Object do
    def merge(other) = other
  end
end
