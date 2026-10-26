# Builds the shields.io coverage badge and writes it into the README.
module CoverageBadge
  class MarkersMissing < StandardError; end

  MARKERS = %r{(<!-- coverage-badge -->).*?(<!-- /coverage-badge -->)}m

  def self.url(percent)
    "https://img.shields.io/badge/coverage-#{format('%.1f', percent)}%25-#{color(percent)}"
  end

  def self.replace(readme, percent)
    raise MarkersMissing, 'README has no coverage-badge markers' unless readme.match?(MARKERS)

    readme.sub(MARKERS, "\\1![coverage](#{url(percent)})\\2")
  end

  def self.color(percent)
    return 'brightgreen' if percent >= 90

    percent >= 75 ? 'yellow' : 'red'
  end
end
