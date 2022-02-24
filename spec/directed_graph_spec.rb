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

end