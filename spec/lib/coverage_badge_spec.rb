require 'rails_helper'
require 'coverage_badge'

RSpec.describe CoverageBadge do
  describe '.url' do
    it 'is green at or above 90%' do
      expect(described_class.url(90)).to eq('https://img.shields.io/badge/coverage-90.0%25-brightgreen')
    end

    it 'is yellow from 75% up to 90%' do
      expect(described_class.url(75.5)).to eq('https://img.shields.io/badge/coverage-75.5%25-yellow')
    end

    it 'is red below 75%' do
      expect(described_class.url(42.123)).to eq('https://img.shields.io/badge/coverage-42.1%25-red')
    end
  end

  describe '.replace' do
    let(:readme) do
      "# App\n<!-- coverage-badge -->![old](x)<!-- /coverage-badge -->\ntext\n"
    end

    it 'swaps the badge between the markers' do
      result = described_class.replace(readme, 80)

      expect(result).to include('<!-- coverage-badge -->![coverage](https://img.shields.io/badge/coverage-80.0%25-yellow)<!-- /coverage-badge -->')
    end

    it 'leaves the rest of the README untouched' do
      result = described_class.replace(readme, 80)

      expect([result.lines.first, result.lines.last]).to eq(["# App\n", "text\n"])
    end

    it 'raises when the markers are missing' do
      expect { described_class.replace("# App\n", 80) }.to raise_error(CoverageBadge::MarkersMissing)
    end
  end
end
