# Similar to the `deep_merge` funcitonality in Rails only it will also merge
# arrays contained in the hash.
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
    alias merge +
  end

  refine Object do
    def merge(other) = other
  end
end
