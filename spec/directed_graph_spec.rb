require 'spec_helper'
require 'directed_graph'

RSpec.describe DirectedGraph do

  describe '.new' do
    context 'default' do
      subject { described_class.new }

      it { expect(subject.size).to be_zero }
    end

    context 'array of vertices' do
      let(:vertices) { 3.times.to_a }
      subject { described_class.new(vertices) }

      it { expect(subject.size).to eq vertices.size }
    end

    context 'adjacency list' do
      let(:list) { { 1 => [], 2 => [1] } }
      subject { described_class.new(list) }

      it { expect(subject.size).to eq list.size }
    end
  end

  describe '#edges' do
    let(:list) { { 1 => [], 2 => [1] } }
    let(:graph) { described_class.new(list) }
    subject { graph.edges(edge) }

    context 'when no edges' do
      let(:edge) { 1 }

      it { is_expected.to be_empty }
    end

    context 'when edges' do
      let(:edge) { 2 }

      it { is_expected.to eq [1].to_set }
    end

    context 'when vertex not in graph' do
      let(:edge) { 3 }

      it { is_expected.to be_empty }
    end
  end

  describe '#reverse_edges' do
    let(:graph) do
      described_class.new(
        1 => [2, 3],
        2 => [3],
        3 => []
      )
    end

    it 'reverses direction of edges' do
      reversed = graph.reverse_edges
      expect(reversed.edges(1)).to be_empty
      expect(reversed.edges(2)).to contain_exactly(1)
      expect(reversed.edges(3)).to contain_exactly(1, 2)
    end
  end

end